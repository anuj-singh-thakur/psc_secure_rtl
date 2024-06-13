from pyverilog.ast_code_generator.codegen import ASTCodeGenerator
from pyverilog.vparser.parser import VerilogCodeParser
import pyverilog.vparser.ast as vast
from graphviz import Digraph
from utils import children_items
import re
import random
from utils import NodeVisitor,AnnotateMultipliers

#temporary updating for testing 
time_scale = "" #"`timescale 1 ns / 1 ps\n"
prefix  = "t"
reg_prefix = "reg"
clk_prefix = "clk"
clk_var_cnt = 1
reg_var_cnt = 1
var_cnt = 1


#set of enables(only few combination will work,not all)
register_pushing_enable = True
register_balancing_enable = True
clock_gating_enable = True
copy_circuit_enable = True
full_copy_enable = False
depth_threshold_copy_circuit = 5

class ComplementCircuit:
    def __init__(self,res=None) -> None:
        #initialize with set of assignment node created during copy_subtree method execution
        self.res = res

    def visit(self,node):
        if (isinstance(node,vast.Unot)):
            return self.visit_Unot(node)
        else:
            return node

    def visit_Unot(self,node,isFlag=False):
        if (isinstance(node.right,vast.Unot)):
            return node.right.right
        elif (isinstance(node.right, vast.Or)):
            or_operation = node.right if(isFlag) else self.visit(node.right)
            or_left = or_operation.left
            or_right = or_operation.right
            if (isinstance(or_left, vast.Unot)):
                or_left = or_left.right
            else:
                or_left = vast.Unot(or_left)
            if (isinstance(or_right, vast.Unot)):
                or_right = or_right.right
            else:
                or_right = vast.Unot(or_right)
            new_op = vast.And(
                left=or_left,
                right=or_right
            )
            node = new_op
        # AND gate
        elif (isinstance(node.right, vast.And)):
            and_operation = node.right if(isFlag) else self.visit(node.right)
            and_left = and_operation.left
            and_right = and_operation.right
            if (isinstance(and_left, vast.Unot)):
                and_left = and_left.right
            else:
                and_left = vast.Unot(and_left)
            if (isinstance(and_right, vast.Unot)):
                and_right = and_right.right
            else:
                and_right = vast.Unot(and_right)
            new_op = vast.Or(
                left=and_left,
                right=and_right
            )
            node = new_op
        # PLUS operation
        elif (isinstance(node.right, vast.Plus)):
            plus_op = node.right if(isFlag) else self.visit(node.right)
            plus_left = plus_op.left
            plus_right = plus_op.right
            if (isinstance(plus_left, vast.Unot)):
                plus_left = plus_left.right
            else:
                plus_left = vast.Unot(plus_left)
            if (isinstance(plus_right, vast.Unot)):
                plus_right = plus_right.right
            else:
                plus_right = vast.Unot(plus_right)
            new_op = vast.Plus(
                plus_left,
                vast.Plus(
                    plus_right,
                    vast.IntConst(1)
                )
            )
            node = new_op
        # MUL operation
        elif (isinstance(node.right, vast.Times)):
            lhs_width = None
            if (hasattr(node.right, "left_shift")):
                lhs_width = getattr(node.right, "left_shift")
            else:
                raise Exception(node.right," Multiply used without left_shift attribute")
            if (lhs_width is None):
                shift_value = vast.IntConst(1)
            else:
                shift_value = vast.Plus(
                    lhs_width.msb,
                    vast.IntConst(1)
                )
            mul_op = node.right if(isFlag) else self.visit(node.right)
            mul_left = mul_op.left
            mul_right = mul_op.right
            # TODO: How to find left shift?
            add_part = vast.Sll(
                vast.Unot(
                    vast.Plus(
                        mul_left,
                        mul_right
                    ),
                ),
                shift_value
            )
            add_part2 = vast.Plus(
                mul_left,
                mul_right
            )
            mul_part = vast.Times(
                vast.Unot(mul_left),
                vast.Unot(mul_right)
            )
            # adding same lhs witdth as per original node
            setattr(mul_part,"left_shift",lhs_width)
            new_op = vast.Plus(
                vast.Minus(
                    add_part,
                    mul_part
                ),
                add_part2
            )
            node = new_op
        # TERNARY Operator
        elif (isinstance(node.right, vast.Cond)):
            tern_op = node.right if(isFlag) else self.visit(node.right)
            condition = tern_op.cond
            false_val = vast.Unot(tern_op.false_value)
            true_val = vast.Unot(tern_op.true_value)
            new_node = vast.Cond(
                condition,
                true_val,
                false_val
            )
            node = new_node
        # SUBTRACTOR
        elif (isinstance(node.right, vast.Minus)):
            sub_op = node.right if(isFlag) else self.visit(node.right)
            sub_left = sub_op.left
            sub_right = sub_op.right
            new_op = vast.Unot(
                vast.Minus(
                    vast.Unot(sub_right),
                    vast.Unot(sub_left)
                )
            )
            node = new_op
        # XOR gate
        elif (isinstance(node.right, vast.Xor)):
            xor_op = node.right if(isFlag) else self.visit(node.right)
            xor_left = xor_op.left
            xor_right = xor_op.right
            random_num = random.uniform(1, 100)
            if (random_num <= 50):
                new_op = vast.Xor(
                    vast.Unot(
                        xor_left
                    ),
                    xor_right
                )
            else:
                new_op = vast.Xor(
                    xor_left,
                    vast.Unot(
                        xor_right
                    )
                )
            node = new_op
        elif (isinstance(node.right, vast.Identifier)):
            print(f"Bubble stuck before Identifier = {node.right.name}")
        elif (isinstance(node.right, (vast.Pointer, vast.Partselect))):
            print(f"Bubble stuck before Identifier = {node.right.var.name}")
        elif (isinstance(node.right, vast.SystemCall)):
            if (node.right.syscall == "signed" and len(node.right.args) == 1):
                signed_arg = node.right.args[0]
                new_node = vast.SystemCall(
                    node.right.syscall,
                    [
                        vast.Unot(
                            node.right.args[0]
                        )
                    ]
                )
                node = new_node
        # CONCAT operator
        elif (isinstance(node.right, vast.Concat)):
            node_right = node.right
            new_concat_list = []
            for child in node_right.list:
                new_concat_list.append(vast.Unot(child))
            new_node = vast.Concat(new_concat_list)
            node = new_node
        else:
            new_right = node.right if(isFlag) else self.visit(node.right)
            node = vast.Unot(new_right)

        return node
    
    def k_level_visit(self,node,level):
        if level <=0:
            return node
        # creating tuple of binary node
        binary_node = (vast.Times,vast.And,vast.Or,vast.Minus,vast.Plus,vast.Xor,vast.Xnor)
        
        if(isinstance(node,vast.Unot)):
            new_node = None
            # checking if node.right is an Identifier or other variable
            if isinstance(node.right,vast.Identifier):
                # we need to check if node is a input or temporary variable
                # if it is temporary variable then we can push bubble to the right side of an assignment statement
                # corresponding to the given Identifier variable. otherwise we just return the variable
                #checking the Assignment statement for current Identifier 
                if(node.right.name in self.res):
                    assign_node = self.res[node.right.name]
                    assign_node.right.var = self.k_level_visit(vast.Unot(assign_node.right.var),level)
                    new_node = node.right
                else:
                    new_node = node
            else:
                #we have to visit the node.right varible 
                new_node = self.k_level_visit(node.right,level)
                #Now we have to apply one level of bubble pushing
                new_node = self.visit_Unot(vast.Unot(new_node),True)

            return new_node       
        elif isinstance(node,binary_node):    
            left = self.k_level_visit(node.left,level-1) if hasattr(node, 'left') else None
            right = self.k_level_visit(node.right,level-1) if hasattr(node, 'right') else None
            new_node = node.__class__(left=left,right=right)
            
            if(isinstance(node,vast.Times) and hasattr(node,"left_shift")):
                lhs_width = getattr(node,"left_shift")
                setattr(new_node,"left_shift",lhs_width)
            
            return new_node
        elif (isinstance(node, vast.Cond)):
            condition = node.cond
            false_val = self.k_level_visit(node.false_value,level-1) if hasattr(node,'false_value') else None
            true_val = self.k_level_visit(node.true_value,level-1) if hasattr(node,'true_value') else None
            new_node = vast.Cond(
                condition,
                true_val,
                false_val
            )
            return new_node
        elif (isinstance(node, (vast.Pointer, vast.Partselect))):
            # TODO: how to handle
            return node
        elif (isinstance(node, vast.SystemCall)):
            if (node.syscall == "signed" and len(node.args) == 1):
                signed_arg = node.args[0]
                new_node = vast.SystemCall(
                    node.syscall,
                    [
                        self.k_level_visit(signed_arg,level-1)
                    ]
                )
                node = new_node
            return node
        elif (isinstance(node, vast.Concat)):
            new_concat_list = []
            # for all the children
            for child in node.list:
                new_concat_list.append(self.k_level_visit(child,level))
            new_node = vast.Concat(new_concat_list)
            node = new_node
            return node
        elif isinstance(node,vast.Identifier):
            return node
        else:
            return node
        

class PSCSecureRtl(NodeVisitor):
    def __init__(self,ast,reg_name,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map) -> None:
        self.ast = ast
        self.reg_name = reg_name
        self.reg_decl = reg_decl
        self.width_dict = width_dict
        self.res = {}
        self.mapping = mapping
        self.vis = {}
        self.depth = 0
        self.binary_node =  (vast.Times,vast.And,vast.Or,vast.Minus,vast.Plus,vast.Xor,vast.Xnor,vast.Srl,vast.Sll)
        self.node_depth = {}
        self.decl_stat_dict = decl_stat_dict
        self.dp = {} #during register balancing we will store reg count and use it later
        self.fanout_map = fanout_map
        self.dp2 = {} #used in find_max_leak_point method
        
    def get_new_sens_name(self):
        global clk_prefix,clk_var_cnt

        sens_condition = clk_prefix + str(clk_var_cnt)
        clk_var_cnt +=1 
        return sens_condition
        

    def get_new_variable_name(self,var_name,isRegName = False):
        global prefix,var_cnt,reg_prefix,reg_var_cnt
        new_name = None
        
        if isRegName or (var_name in self.decl_stat_dict and type(self.decl_stat_dict[var_name])==vast.Reg):
            new_name = var_name + "_" + reg_prefix + str(reg_var_cnt)
            reg_var_cnt+=1
        else:
            new_name = prefix + str(var_cnt) + "_" + var_name
            var_cnt+=1

        return new_name

    def copy_subtree(self, node, depth=0):
        #print(node,depth)
        # to get max depth of the subtree
        global depth_threshold_copy_circuit
        if depth>depth_threshold_copy_circuit:
            return node

        self.depth = max(self.depth,depth)

        # creating tuple of binary node
        binary_node = self.binary_node
        
        if(isinstance(node,vast.Unot)):
            new_node = self.copy_subtree(node.right,depth)
            return vast.Unot(new_node)   
        
        if isinstance(node,vast.Ulnot):
            new_node = self.copy_subtree(node.right,depth)
            return vast.Ulnot(new_node)
             
        elif isinstance(node,binary_node):    
            left = self.copy_subtree(node.left,depth+1) if hasattr(node, 'left') else None
            right = self.copy_subtree(node.right,depth+1) if hasattr(node, 'right') else None
            new_node = node.__class__(left=left,right=right)
            if(isinstance(node,vast.Times) and hasattr(node,"left_shift")):
                lhs_width = getattr(node,"left_shift")
                setattr(new_node,"left_shift",lhs_width)
            return new_node
        
        elif (isinstance(node, vast.Cond)):
            condition = node.cond
            false_val = self.copy_subtree(node.false_value,depth+1) if hasattr(node,'false_value') else None
            true_val = self.copy_subtree(node.true_value,depth+1) if hasattr(node,'true_value') else None
            new_node = vast.Cond(
                condition,
                true_val,
                false_val
            )
            node = new_node
            return node
        elif (isinstance(node, (vast.Pointer, vast.Partselect))):
            # TODO: how to handle: completed on 13th May 24.
            new_node = self.copy_subtree(node.var,depth)

            if(isinstance(node,vast.Pointer)):
                new_node = vast.Pointer(var=new_node,ptr=node.ptr)
            else:
                new_node = vast.Partselect(var=new_node,msb=node.msb,lsb=node.lsb)
            return new_node
        elif (isinstance(node, vast.SystemCall)):
            if (node.syscall == "signed" and len(node.args) == 1):
                signed_arg = node.args[0]
                new_node = vast.SystemCall(
                    node.syscall,
                    [
                        self.copy_subtree(signed_arg,depth+1)
                    ]
                )
                node = new_node
            return node
        elif (isinstance(node, vast.Concat)):
            new_concat_list = []
            for child in node.list:
                new_concat_list.append(self.copy_subtree(child,depth))
            new_node = vast.Concat(new_concat_list)
            node = new_node
            return node
        elif isinstance(node,vast.Identifier):
            #checking the Assignment statement for current Identifier 
            if(node.name in self.mapping):
                
                assign_node = self.mapping[node.name]
                global full_copy_enable
                if not full_copy_enable:
                    if(hasattr(assign_node.left.var,"isCopiedCircuit") and getattr(assign_node.left.var,"isCopiedCircuit")):
                        print("----already copied:",node.name)
                        return node

                new_var_name = self.get_new_variable_name(node.name)
                self.vis[new_var_name] = node.name

        
                assign_right_node = self.copy_subtree(assign_node.right.var,depth)
                assign_left_node = vast.Identifier(new_var_name)
                
                if isinstance(assign_node.left.var,vast.Pointer):
                    assign_left_node = vast.Pointer(var=assign_left_node,ptr=assign_node.left.var.ptr)
                elif isinstance(assign_node.left.var,vast.Partselect):
                    assign_left_node = vast.Partselect(var=assign_left_node,msb=assign_node.left.var.msb,lsb=assign_node.left.var.lsb)
                    
                lvalue = vast.Lvalue(assign_left_node)
                rvalue = vast.Rvalue(assign_right_node)
                
                # we have to copy all the attribute during copy circuit
                if(hasattr(assign_node.left.var ,"reg_req")):
                    setattr(lvalue.var,"reg_req",getattr(assign_node.left.var,"reg_req"))
              
                # create copy based on it's type.
                if type(assign_node) == vast.Assign:
                    assign_node = vast.Assign(lvalue,rvalue)
                elif type(assign_node) == vast.BlockingSubstitution:
                    assign_node = vast.BlockingSubstitution(lvalue,rvalue)
                else:
                    assign_node = vast.NonblockingSubstitution(lvalue,rvalue)
                
                
                self.res[new_var_name] = assign_node

                new_node = node.__class__(new_var_name)

                #adding updated assignment node into mapping for future use
                #self.mapping[new_var_name] = assign_node
                return new_node
            else:
                return node
        else:
            return node
    
    def select_uniform_indexes(self,n, k):
        if k > n:
            raise ValueError("k cannot be greater than n")
        
        # Generate a list of all possible indexes
        all_indexes = list(range(n))
        
        # Shuffle the list of indexes
        random.shuffle(all_indexes)
        
        # Select the first k indexes
        selected_indexes = all_indexes[:k]
        
        return selected_indexes

    def k_level_bubble_pushing(self):
        #from new variable mapping getting all the keys to select k random values
        keys = list(self.res.keys())
        n = len(keys)
        k = min(n//2,50)

        selected_indexes = self.select_uniform_indexes(n,k)

        complementCircuit = ComplementCircuit()
        print(n,k,selected_indexes)
        for index in selected_indexes:
            # get the assignment statement based on the key of current index
            node = self.res[keys[index]]
            complement_node = complementCircuit.visit(vast.Unot(node.right.var))
            node.right.var = vast.Unot(complement_node)

    def register_pushing(self,node,level,root_reg):
        if level<=0:
            new_var_name = self.get_new_variable_name(root_reg,True)
            self.vis[new_var_name] = root_reg

            assign_left_node = vast.Identifier(new_var_name)
            assign_right_node = node

            lvalue = vast.Lvalue(assign_left_node)
            rvalue = vast.Rvalue(assign_right_node)

            assign_node = vast.NonblockingSubstitution(lvalue,rvalue)
            self.res[new_var_name] = assign_node

            return assign_left_node
        else:
            # creating tuple of binary node
            binary_node = self.binary_node
            
            if(isinstance(node,vast.Unot)):
                new_node = self.register_pushing(node.right,level,root_reg)
                return vast.Unot(new_node)
            elif isinstance(node,vast.Ulnot):
                new_node = self.register_pushing(node.right,level,root_reg)
                return vast.Ulnot(new_node)
            elif isinstance(node,binary_node):    
                left = self.register_pushing(node.left,level-1,root_reg) if hasattr(node, 'left') else None
                right = self.register_pushing(node.right,level-1,root_reg) if hasattr(node, 'right') else None
                new_node = node.__class__(left=left,right=right)
                if(isinstance(node,vast.Times) and hasattr(node,"left_shift")):
                    lhs_width = getattr(node,"left_shift")
                    setattr(new_node,"left_shift",lhs_width)
                return new_node
            
            elif (isinstance(node, vast.Cond)):
                condition = node.cond
                false_val = self.register_pushing(node.false_value,level-1,root_reg) if hasattr(node,'false_value') else None
                true_val = self.register_pushing(node.true_value,level-1,root_reg) if hasattr(node,'true_value') else None
                new_node = vast.Cond(
                    condition,
                    true_val,
                    false_val
                )
                return new_node
            elif (isinstance(node, (vast.Pointer, vast.Partselect))):
                # TODO: how to handle: completed on 13th May 24
                return self.register_pushing(node,0,root_reg)
            elif (isinstance(node, vast.SystemCall)):
                if (node.syscall == "signed" and len(node.args) == 1):
                    signed_arg = node.args[0]
                    new_node = vast.SystemCall(
                        node.syscall,
                        [
                            self.register_pushing(signed_arg,level-1,root_reg)
                        ]
                    )
                    node = new_node
                return node
            elif (isinstance(node, vast.Concat)):
                new_concat_list = []
                for child in node.list:
                    new_concat_list.append(self.register_pushing(child,level,root_reg))
                new_node = vast.Concat(new_concat_list)
                return new_node
            elif isinstance(node,vast.Identifier):
                #checking the current variable fanout
                #incase of multiple fanout we will not push further
                if node.name in self.fanout_map and self.fanout_map[node.name]>1:
                    return self.register_pushing(node,0,root_reg)

                #checking the Assignment statement for current Identifier 
                if(node.name in self.mapping):
                    assign_node = self.mapping[node.name]
                    assign_node.right.var = self.register_pushing(assign_node.right.var,level,root_reg)
                    return node
                else:
                    return self.register_pushing(node,0,root_reg)                
            else:
                return self.register_pushing(node,0,root_reg)
    
    def add_reg(self,node,reg_cnt,root_reg):        
        '''
            from the current node add reg based on the reg_cnt 
        '''
        if(reg_cnt>0):
            while(reg_cnt>0):
                node = self.register_pushing(node,0,root_reg)
                reg_cnt-=1
            return node
        else:
            return node
        
    def register_balancing(self,node,root_reg):
        '''
            If any path has fewer register compared to max letency of overall circuit then
            we have to balance those path to make uniform latency.
        '''
        
        binary_node = self.binary_node

        if isinstance(node,vast.Identifier):
            if(node.name in self.mapping):
                
                if(node.name in self.dp):
                    return (node,self.dp[node.name])


                assign_node = self.mapping[node.name]            
                assign_node.right.var, reg_cnt = self.register_balancing(assign_node.right.var,root_reg)
                
                if type(self.decl_stat_dict[node.name])==vast.Reg:
                    reg_cnt+=1
                
                self.dp[node.name] = reg_cnt
                return (node,reg_cnt)
            else:
                return (node,0)
        
        elif isinstance(node,vast.Unot):
            new_node,reg_cnt = self.register_balancing(node.right,root_reg)
            return (vast.Unot(new_node),reg_cnt)
        elif isinstance(node,vast.Ulnot):
            new_node,reg_cnt = self.register_balancing(node.right,root_reg)
            return (vast.Ulnot(new_node),reg_cnt)
        elif isinstance(node,binary_node):
            left, left_reg_cnt = self.register_balancing(node.left,root_reg) if hasattr(node,'left') else (None,None)
            right,right_reg_cnt = self.register_balancing(node.right,root_reg) if hasattr(node,'right') else (None,None)


            left = self.add_reg(left,right_reg_cnt-left_reg_cnt,root_reg)
            right = self.add_reg(right,left_reg_cnt-right_reg_cnt,root_reg)

            new_node = node.__class__(left=left,right=right)
            if(isinstance(node,vast.Times) and hasattr(node,"left_shift")):
                lhs_width = getattr(node,"left_shift")
                setattr(new_node,"left_shift",lhs_width)
            
            return (new_node,max(left_reg_cnt,right_reg_cnt))
        elif (isinstance(node, vast.Cond)):
            condition = node.cond
            false_val, false_reg_cnt = self.register_balancing(node.false_value,root_reg) if hasattr(node,'false_value') else (None,None)
            true_val, true_reg_cnt = self.register_balancing(node.true_value,root_reg) if hasattr(node,'true_value') else (None,None)
            
            false_val = self.add_reg(false_val,true_reg_cnt-false_reg_cnt,root_reg)
            true_val = self.add_reg(true_val,false_reg_cnt-true_reg_cnt,root_reg)
           
            new_node = vast.Cond(
                condition,
                true_val,
                false_val
            )
            return (new_node,max(false_reg_cnt,true_reg_cnt))
        elif (isinstance(node, (vast.Pointer, vast.Partselect))):
            # TODO: how to handle:  completed on 13th May 24.
            new_node,reg_cnt = self.register_balancing(node.var,root_reg=root_reg)
            if(isinstance(node,vast.Pointer)):
                new_node = vast.Pointer(var=new_node,ptr=node.ptr)
            else:
                new_node = vast.Partselect(var=new_node,msb=node.msb,lsb=node.lsb)
            return (new_node,reg_cnt)
        elif (isinstance(node, vast.SystemCall)):
            reg_cnt = 0
            if (node.syscall == "signed" and len(node.args) == 1):
                signed_arg = node.args[0]
                
                right_node,reg_cnt = self.register_balancing(signed_arg,root_reg)
                
                new_node = vast.SystemCall(
                    node.syscall,
                    [
                        right_node
                    ]
                )
                node = new_node
            return (node,reg_cnt)
        
        elif (isinstance(node, vast.Concat)):
            tmp_list = []
            max_reg_cnt = 0
            for child in node.list:
                new_child,reg_cnt = self.register_balancing(child,root_reg)
                tmp_list.append([new_child,reg_cnt])
                max_reg_cnt = max(max_reg_cnt,reg_cnt)

            for i in range(len(tmp_list)):
                tmp_list[i][0] = self.add_reg(tmp_list[i][0],max_reg_cnt-tmp_list[i][1],root_reg)

            new_concat_list = []
            for (new_child,reg_cnt) in tmp_list:
                new_concat_list.append(new_child)

            new_node = vast.Concat(new_concat_list)
            return (new_node,max_reg_cnt)
        else:
            return (node,0)

    def find_max_leak_point(self,node,depth=0):
        '''
            Initially this method was written for find max leaky point in any path, but later
            we have used this method to find max reg (latency) in any path 
        '''

        binary_node = self.binary_node
        if isinstance(node,vast.Identifier):
            if depth>0:
                if node.name in self.node_depth:
                    self.node_depth[node.name] = max(depth,self.node_depth[node.name])
                else:    
                    self.node_depth[node.name] = depth

            if(node.name in self.mapping):
                assign_node = self.mapping[node.name]
                if node.name in self.dp2:
                    return self.dp2[node.name]
                
                leak_point_cnt = 0
                #if hasattr(assign_node.left.var,"reg_req") and assign_node.left.var.reg_req>0:
                #    leak_point_cnt += 1

                if type(self.decl_stat_dict[node.name])==vast.Reg:
                    leak_point_cnt+=1

                leak_point_cnt += self.find_max_leak_point(assign_node.right.var,depth+1)
                self.dp2[node.name] = leak_point_cnt   
                return leak_point_cnt                
            else:
                return 0
        
        elif isinstance(node,vast.Unot):
            return self.find_max_leak_point(node.right,depth+1) 
        elif isinstance(node,vast.Ulnot):
            return self.find_max_leak_point(node.right,depth+1)       
        elif isinstance(node,binary_node):
            left_val  = self.find_max_leak_point(node.left,depth+1) if hasattr(node,'left') else 0
            right_val = self.find_max_leak_point(node.right,depth+1) if hasattr(node,'right') else 0
            if left_val!=right_val:
                print("Node: ",node,left_val,right_val)
            return max(left_val,right_val)
        
        elif isinstance(node,vast.Cond):
            false_val  = self.find_max_leak_point(node.false_value,depth+1) if hasattr(node,'false_value') else 0
            true_val = self.find_max_leak_point(node.true_value,depth+1) if hasattr(node,'true_value') else 0
            if false_val!=true_val:
                print("Node: ",node,false_val,true_val)
            return max(false_val,true_val)
        
        elif (isinstance(node, (vast.Pointer, vast.Partselect))):
            # TODO: how to handle: completed on 13th May 24.
            return self.find_max_leak_point(node.var,depth+1)
        
        elif (isinstance(node, vast.SystemCall)):
            leak_point_cnt = 0
            if (node.syscall == "signed" and len(node.args) == 1):
                signed_arg = node.args[0]
                
                leak_point_cnt = self.find_max_leak_point(signed_arg,depth+1)
            return leak_point_cnt
        
        elif (isinstance(node, vast.Concat)):
            leak_point_cnt = 0
            for child in node.list:
                child_val = self.find_max_leak_point(child,depth+1)
                leak_point_cnt = max(leak_point_cnt,child_val)
            return leak_point_cnt
        else:
            return 0
        
        
    def get_reg_list(self,node,depth):
        if(depth>self.depth):
            return []
        
        binary_node = self.binary_node
        
        if isinstance(node,vast.Identifier):
            if node.name in self.fanout_map and self.fanout_map[node.name]>1:
                return []

            if(node.name in self.mapping):
                assign_node = self.mapping[node.name]
                reg_list = self.get_reg_list(assign_node.right.var,depth)
                if type(self.decl_stat_dict[node.name])==vast.Reg:
                    reg_list.append(node.name)
                return reg_list                
            else:
                return []
        
        elif isinstance(node,(vast.Unot,vast.Ulnot)):
            return self.get_reg_list(node.right,depth)
        elif isinstance(node,binary_node):
            left_list  = self.get_reg_list(node.left,depth+1) if hasattr(node,'left') else 0
            right_list = self.get_reg_list(node.right,depth+1) if hasattr(node,'right') else 0
            return left_list+right_list
        elif isinstance(node,vast.Cond):
            false_list  = self.get_reg_list(node.false_value,depth+1) if hasattr(node,'false_value') else 0
            true_list = self.get_reg_list(node.true_value,depth+1) if hasattr(node,'true_value') else 0    
            return false_list + true_list
        
        elif (isinstance(node, (vast.Pointer, vast.Partselect))):
            # TODO: how to handle: completed on 13th May 24.
            return self.get_reg_list(node.var,depth)
        
        elif (isinstance(node, vast.SystemCall)):
            reg_list = []
            if (node.syscall == "signed" and len(node.args) == 1):
                signed_arg = node.args[0]
                reg_list = self.get_reg_list(signed_arg,depth+1)
            return reg_list
        
        elif (isinstance(node, vast.Concat)):
            reg_list = []
            for child in node.list:
                tmp_list = self.get_reg_list(child,depth)
                reg_list.extend(tmp_list)
            return reg_list
        else:
            return []
    
    def get_mux_node(self,node,left_reg_name,isUnot=False):
        global copy_circuit_enable
        if not copy_circuit_enable:
            org_push_level = random.randint(1, 5)
            print("org_push_level:",org_push_level)
            node = self.register_pushing(node,org_push_level,left_reg_name)
            return node

        #find complement of current node
        complement_node = self.copy_subtree(node,0) # passing initial depth of the subtree as 0
        complementCircuit = ComplementCircuit(self.res)
        complement_node = complementCircuit.visit(vast.Unot(complement_node))
        complement_node = complement_node if(isUnot) else vast.Unot(complement_node)
        #apply bubble pushing into k level among n
        self.k_level_bubble_pushing()
        print("subtree depth",self.depth)
        
        # based on the depth of copied circuit we apply k level bubble pushing
        percentage_array  = [0.35,0.45,0.65,0.85]
        percentage_array_reg_push = [0.55,0.75,0.85,0.95]
        option = random.randint(0, 3)

        k = self.depth if self.depth<2 else int(self.depth*percentage_array[option])
        if(self.depth>1):
            print("Bubble Pushing Depth:",k)
            # we can select 1 to k randomly, currently keeping all k level
            complement_node = complementCircuit.k_level_visit(complement_node,k)
    
        #register pushing for original and copied complement circuit
        global register_pushing_enable,full_copy_enable
        if (register_pushing_enable):
            org_push_level = int((self.depth - k)*percentage_array_reg_push[random.randint(0,3)]) if full_copy_enable else (self.depth - k)
            #org_push_level = 0
            print("org_push_level:",org_push_level)
            node = self.register_pushing(node,org_push_level,left_reg_name)
            cmp_push_level = int(k*percentage_array_reg_push[random.randint(0,3)]) if full_copy_enable else k
            #cmp_push_level = 0
            print("cmp_push_level:",cmp_push_level)
            complement_node = self.register_pushing(complement_node,cmp_push_level,left_reg_name)


        condition = None

        if len(self.reg_decl) > 0:
            # selecting random register from module definition
            start,end = 0,len(self.reg_decl)-1
            reg_position = random.randint(start,end)
            reg_name = self.reg_decl[reg_position].name

            lsb = self.width_dict[reg_name][0]
            msb  = self.width_dict[reg_name][1]
            
            #print(int(lsb.value),int(msb.value))
            
            selected_register = reg_name
            selected_bit = random.randint(int(lsb.value),int(msb.value))
            #condition = vast.Partselect(vast.Identifier(selected_register), vast.IntConst(selected_bit), vast.IntConst(selected_bit))
            condition = vast.Pointer(var=vast.Identifier(selected_register),ptr=vast.IntConst(selected_bit))
        else:
            #when there are no register in the verilog file except output or 1 bit.
            val = random.randint(0,1)
            condition = vast.IntConst(val, 1)

        #select = vast.IntConst(1, 1) 
        select = condition
        # Create the true case of the MUX, which is the And of the node's inputs
        true_case = node
        # Create the false case of the MUX, which is the complement of the inputs
        false_case = complement_node 

        #random_num = random.uniform(1, 100)
        # randomly add true or false case
        #if(random_num<50):
        #    true_case,false_case = false_case,true_case

        # Create the MUX using the select signal, true case, and false case
        mux = vast.Cond(select, true_case, false_case)

        return mux

    def visit_AnyAssignment(self, node):
        reg_name = None
        # is_pointer is for assign statements of the form "reg[0] = value"
        is_pointer = isinstance(node.left.var, vast.Pointer)

        # is_part_select is for assign statements of the form "reg[4:0] = value"
        is_part_select = isinstance(node.left.var, vast.Partselect)

        if (is_pointer or is_part_select):
            reg_name = node.left.var.var.name
        else:
            reg_name = node.left.var.name

        if (reg_name == self.reg_name):
            print("Reg: ",reg_name)
        
            node_rvalue = node.right
            # If it is of the form "x = ~y", then remove the not
            if (isinstance(node_rvalue.var, vast.Unot)):
                #node.right.var = node_rvalue.var.right
                node.right.var = self.get_mux_node(node_rvalue.var.right,reg_name,True)
            else:
                    
                #node.right.var = vast.Unot(node_rvalue.var)
                node.right.var = self.get_mux_node(node_rvalue.var,reg_name)

            # Adding 'reg_req' variable to the LHS so we can add register.
            setattr(node.left.var, "reg_req",1) #default count of register is 1
            setattr(node.left.var,"isCopiedCircuit",True);
            print("-"*50)
        
        # Annotate LHS values to avoid adding NOT gate infront of them
        setattr(node.left.var, "is_lhs", True)
        return node
    def visit_Assign(self, node):
        return self.visit_AnyAssignment(node)

    def visit_NonblockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)

    def visit_BlockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)



def get_declared_register(module_definition):
    module_children = module_definition.children()
    reg_decl = [x for x in module_children if type(x) == vast.Decl]
    reg_decl = [child for x in reg_decl for child in x.children()]
    reg_decl = [x for x in reg_decl if isinstance(x, vast.Input)] #isinstance(x, vast.Reg)

    width_dict = {}     
    filtered_reg_decl = []

    pattern = r'^ap_'
    for i in range(len(reg_decl)):
        if re.match(pattern,reg_decl[i].name):
            continue 
        if reg_decl[i].dimensions!=None:
            continue
        lsb = vast.IntConst(0)
        msb = reg_decl[i].width.msb if (reg_decl[i].width is not None) else vast.IntConst(0)
        #changing the condition from "and" to "or" 
        #we can't use 1 bit register during part select.
        if(msb==lsb or re.search("_ap_",reg_decl[i].name)):
            continue

        filtered_reg_decl.append(reg_decl[i])
        width_dict[reg_decl[i].name] = [lsb,msb]

    return filtered_reg_decl,width_dict

def ast_to_graphviz(node, graph):
    if node is None:
        return
    graph.node(str(id(node)), str(node.__class__.__name__))
    for child_name, child_node in children_items(node):
        child_id = str(id(child_node))
        graph.node(child_id, str(child_node))
        graph.edge(str(id(node)), child_id, label=child_name)
        ast_to_graphviz(child_node, graph)

def store_fanout_cnt(node,fanout_map):
    binary_node = (vast.Times,vast.And,vast.Or,vast.Minus,vast.Plus,vast.Xor,vast.Xnor)    
    if isinstance(node,vast.Identifier):
        if node.name in fanout_map:
            fanout_map[node.name] += 1
        else:
            fanout_map[node.name] = 1
    elif isinstance(node,vast.Unot):
        store_fanout_cnt(node.right,fanout_map)
    elif isinstance(node,binary_node):
        if hasattr(node,'left'):
            store_fanout_cnt(node.left,fanout_map)
        if hasattr(node,'right'):
            store_fanout_cnt(node.right,fanout_map)
    elif isinstance(node,vast.Cond):
        if hasattr(node,'false_value'):
            store_fanout_cnt(node.false_value,fanout_map)
        if hasattr(node,'true_value'):
            store_fanout_cnt(node.true_value,fanout_map) 
    elif (isinstance(node, (vast.Pointer, vast.Partselect))):
        # TODO: how to handle: completed on 13th May 24
        store_fanout_cnt(node.var)
    elif (isinstance(node, vast.SystemCall)):
        if (node.syscall == "signed" and len(node.args) == 1):
            store_fanout_cnt(node.args[0],fanout_map)
    elif (isinstance(node, vast.Concat)):
        for child in node.list:
            store_fanout_cnt(child,fanout_map)

def preprocess(items):
    '''
        to support clock gating, if any always block have more than one statement
        then we will create separate always block. 
    '''
    modified_items = []

    for item in items:
        if type(item) == vast.Always:
            for state in item.statement.statements:

                #we can use same list but later we have to modified the sens condition
                #creating a new object for each statement
                new_sens_list = []
                for x in item.sens_list.list:
                    new_sens_list.append(vast.Sens(sig=x.sig,type=x.type))
                sens_list = vast.SensList(tuple(new_sens_list))
                    
                statement = vast.Block(statements=(state,))
                always_stat = vast.Always(sens_list=sens_list,statement=statement)
                modified_items.append(always_stat)
        else:
            modified_items.append(item)

    return tuple(modified_items)


def postprocess(items,pscSecureRtl):
    '''
        If there is any condition added during clock gating then we will create new clk
        assign the value of existing condition and replace that condition with new clk variable
    '''
    modified_items = []

    for item in items:
        if type(item) == vast.Always:
            new_sens_list = []
            for x in item.sens_list.list:
                if(type(x.sig)==vast.Identifier):
                    new_sens_list.append(vast.Sens(sig=x.sig,type=x.type))
                else:
                    new_sens_cond_name = pscSecureRtl.get_new_sens_name()
                    
                    assign_left_node = vast.Identifier(new_sens_cond_name)  
                    assign_right_node = x.sig

                    lvalue = vast.Lvalue(assign_left_node)
                    rvalue = vast.Rvalue(assign_right_node)
                    
                    assign_node = vast.Assign(lvalue,rvalue)
                    new_sens_list.append(vast.Sens(sig=assign_left_node,type=x.type))
                   
                    new_var = vast.Wire(name=new_sens_cond_name,width=None,signed=False)
                    modified_items.append(new_var)
                    modified_items.append(assign_node)    
            item.sens_list.list = tuple(new_sens_list)
        modified_items.append(item)

    return tuple(modified_items)



def print_breakline():
    print("--"*30)

def main(file_name):
    new_name = f"{file_name.split('.v')[0]}_mux.v"
    #keep the input register list as {module-name}_register_list.txt
    register_file_path = file_name.rsplit('/', 1)[0]

    codeparser = VerilogCodeParser([file_name],
                                preprocess_include=None,
                                preprocess_define=None)

    ast = codeparser.parse()

    module_defs = [x for x in ast.description.definitions if type(x) == vast.ModuleDef]
    
    for module_definition in module_defs:
        register_file_name = register_file_path + "/" + module_definition.name + "_register_list.txt"


        module_definition.items = preprocess(module_definition.items)

        module_children = module_definition.children()
        assign_stat = [x for x in module_children if type(x)==vast.Assign]
        decl_stat = [x for x in module_children if type(x)==vast.Decl]
        always_stat = [x for x in module_children if type(x)==vast.Always]

        #storing all the declared reg and wire mapping (used during new variable created after execution of copy circuit)
        decl_stat_dict = {}
        # storing all the output variable (we will use during register balancing.)
        output_stat = []

        for stat in decl_stat:
            for child in stat.list:
                if(type(child) in (vast.Reg,vast.Wire)):
                    decl_stat_dict[child.name] = child                
                elif type(child) == vast.Output:
                    output_stat.append(child.name)

        # storing how many times variable used in the right side of the expression
        fanout_map = {}
        # storing mapping of all assignment, blocking and non-blocking statements.
        mapping = {}
        for statement in assign_stat:
            key = statement.left.var.name
            if key in mapping:
                raise Exception(key+ " node name used more than once...")
            mapping[key] = statement
            store_fanout_cnt(node=statement.right.var,fanout_map=fanout_map)

        # storing mapping of all blocking and non-blocking statements belong to which always block
        always_block_mapping = {}
       
        for a_statement in always_stat:
            for child in a_statement.statement.statements:
                key = None
                
                try:
                    if isinstance(child.left.var,(vast.Partselect,vast.Pointer)):
                        key = child.left.var.var.name
                    else:
                        key = child.left.var.name
                except:
                    print("this is not Blocking or NonBlocking statement")
                    continue
                if key in mapping:
                    raise Exception(key+ " node name used more than once...")
                mapping[key] = child
                always_block_mapping[key] = a_statement
                store_fanout_cnt(node=child.right.var,fanout_map=fanout_map)


        reg_decl,width_dict = get_declared_register(module_definition)

        multiplyAnnotator = AnnotateMultipliers(ast)
        ast = multiplyAnnotator.visit(ast)   

        try:
            with open(register_file_name, "r") as file:
                lock_register_list = file.readlines()
        except FileNotFoundError:
                print(f"The file '{register_file_name}' is not found. Please make sure the file exists.")
                continue
        
        def update_module_definition(pscSecureRtl,reg_name=None):
            """
                For Each new variable used during, creating a copy of
                subtree, we are adding there declaration based on the old variable
                description 
            """
            list_of_decl_var = []
            for new_var_name in pscSecureRtl.vis:
                # iterating through all the variable and checking if they are present
                # in the declaration statements dictionary
                variable = pscSecureRtl.vis[new_var_name]
                if variable in decl_stat_dict:
                    var = decl_stat_dict[variable]
                    new_var = None
                    
                    #checking the type of variable 
                    #or condition added later to support protection starting from wire variable
                    if type(var)==vast.Reg or type(pscSecureRtl.res[new_var_name]) != vast.Assign:
                        new_var = vast.Reg(name=new_var_name,width=var.width,signed=var.signed)
                    else:
                        new_var = vast.Wire(name=new_var_name,width=var.width,signed=var.signed)
                    
                    # finally wrapping the variable as Declared
                    list_of_decl_var.append(vast.Decl(list=(new_var,)))
                    decl_stat_dict[new_var_name] = new_var
                else:
                    raise Exception(variable+ " used without declaration...")

            #adding only assignment statements.
            filtered_res = []
            for key,statement in pscSecureRtl.res.items():
                mapping[key] = statement
                store_fanout_cnt(statement.right.var,fanout_map)
                if(type(statement)==vast.Assign):
                    filtered_res.append(statement)
                else:
                    #other statements like blocking or non-blocking can be added directly to their 
                    #respective always block with the help of 'always_block_mapping'
                    old_variable = pscSecureRtl.vis[key]
                    if old_variable in always_block_mapping:
                        always_block = always_block_mapping[old_variable]
                        
                        #for each new statement belong to always block create new always statement
                        new_sens_list = []
                        for x in always_block.sens_list.list:
                            new_sens_list.append(vast.Sens(sig=x.sig,type=x.type))
                        sens_list = vast.SensList(tuple(new_sens_list))
                            
                        statement = vast.Block(statements=(statement,))
                        always_stat = vast.Always(sens_list=sens_list,statement=statement)
                        #updating mapping 
                        always_block_mapping[key] = always_stat
                        filtered_res.append(always_stat)
                    elif old_variable in decl_stat_dict and type(decl_stat_dict[old_variable])==vast.Wire:
                        #this code is added to support wire variable..
                        clk_sens_list = vast.Sens(sig=vast.Identifier("clk"),type="posedge")
                        clk_statement = vast.Block(statements=(statement,))
                        clk_always_stat = vast.Always(sens_list=vast.SensList((clk_sens_list,)),statement=clk_statement)
                        always_block_mapping[key] = clk_always_stat
                        filtered_res.append(clk_always_stat)
                    else:
                        raise Exception(old_variable+ " used in always block but mapping not found.")
            
            #------clock gating code implementation------------------------
            global clock_gating_enable
            if(clock_gating_enable):
                def change_sens_condition(stat_list,cond):
                    for stat in stat_list:
                        always_block = always_block_mapping[stat]
                        new_sens_list = []
                        for x in always_block.sens_list.list:
                            right_node = vast.And(left=cond,right=x.sig)
                            new_sens_list.append(vast.Sens(sig=right_node,type=x.type))
                        always_block.sens_list.list = tuple(new_sens_list)   
                #---if we are creating duplicate circuit from the given condition then only 
                #---we have to implement clock gating
                if reg_name!=None:
                    assign_node = mapping[reg_name]
                    if type(assign_node.right.var)==vast.Cond:              
                        cond_node = assign_node.right.var
                        cond = cond_node.cond

                        true_node_list = pscSecureRtl.get_reg_list(cond_node.true_value,0)
                        false_node_list = pscSecureRtl.get_reg_list(cond_node.false_value,0)
                        
                        assert(len(list(set(true_node_list).intersection(false_node_list)))==0)
                        
                        change_sens_condition(true_node_list,cond=cond)
                        change_sens_condition(false_node_list,cond=vast.Unot(cond))
            
            """
                Finally we are adding modified statements and newly declared variable into 
                Module Definition
            """
            module_definition.items = tuple(list_of_decl_var) + module_definition.items + tuple(filtered_res)

        def get_latency(pscSecureRtl):
            latency = 0
            for stat in output_stat:
                assign_node = mapping[stat]
                tmp_latency = pscSecureRtl.find_max_leak_point(assign_node.left.var,1)
                latency = max(latency,tmp_latency)
            return latency

        pscSecureRtl = PSCSecureRtl(ast,None,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map)   
        prev_latency = get_latency(pscSecureRtl)
        
        print_breakline()
        print("prev latency", prev_latency)
        print_breakline()
        #list all the register based on their label in ast
        
        node_depth_list = []
        for k,v in pscSecureRtl.node_depth.items():
            #if k in decl_stat_dict and type(decl_stat_dict[k]) == vast.Reg:
            node_depth_list.append((v,k))
        sorted_list = sorted(node_depth_list, key=lambda x: x[0])
        #for _ in sorted_list:
        #    print(_)
        #print_breakline()
        
        #searching all the leaky reg in node_depth mapping and storing their level in ast
        lock_reg_list_srt = []
        for reg_name in lock_register_list:
            reg_name = reg_name.strip()
            if reg_name in pscSecureRtl.node_depth:
                lock_reg_list_srt.append((pscSecureRtl.node_depth[reg_name],reg_name))
            else:
                print(reg_name," variable depth missing...!!")
        #sorting all the leaky reg in reverse of order of their level
        lock_reg_list_srt = sorted(lock_reg_list_srt,reverse=True)
        
        for (level,reg_name) in lock_reg_list_srt:
            print(level,reg_name)
            reg_name = reg_name.strip()
            pscSecureRtl = PSCSecureRtl(ast,reg_name,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map)
            #ast = pscSecureRtl.visit(ast)
			
            ''' 
            this will make code faster, if this is not working 
            then uncomment the previous line and comment below 2 lines.
            '''
            if reg_name in mapping.keys():
                mapping[reg_name] = pscSecureRtl.visit_AnyAssignment(mapping[reg_name])
        
            update_module_definition(pscSecureRtl = pscSecureRtl,reg_name = reg_name)
                
        
        #register balancing code.
        global register_balancing_enable
        if(register_balancing_enable):        
            reg_balancing_req  = {}
            max_reg_in_path = 0
            for stat in output_stat:
                pscSecureRtl = PSCSecureRtl(ast,None,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map)
                assign_node = mapping[stat]
                
                reg_name = None
                # is_pointer is for assign statements of the form "reg[0] = value"
                is_pointer = isinstance(assign_node.left.var, vast.Pointer)
                # is_part_select is for assign statements of the form "reg[4:0] = value"
                is_part_select = isinstance(assign_node.left.var, vast.Partselect)

                if (is_pointer or is_part_select):
                    reg_name = assign_node.left.var.var.name
                else:
                    reg_name = assign_node.left.var.name

                assign_node.right.var, reg_cnt = pscSecureRtl.register_balancing(assign_node.right.var,reg_name)
                max_reg_in_path = max(max_reg_in_path,reg_cnt)
                reg_balancing_req[assign_node] = reg_cnt
                update_module_definition(pscSecureRtl)

            for (stat,reg_cnt) in reg_balancing_req.items():
                pscSecureRtl = PSCSecureRtl(ast,None,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map)
                reg_name = None
                # is_pointer is for assign statements of the form "reg[0] = value"
                is_pointer = isinstance(stat.left.var, vast.Pointer)
                # is_part_select is for assign statements of the form "reg[4:0] = value"
                is_part_select = isinstance(stat.left.var, vast.Partselect)

                if (is_pointer or is_part_select):
                    reg_name = stat.left.var.var.name
                else:
                    reg_name = stat.left.var.name

                stat.right.var = pscSecureRtl.add_reg(stat.right.var,max_reg_in_path-reg_cnt,reg_name)
                update_module_definition(pscSecureRtl)
          
        #final approach
        module_definition.items = postprocess(module_definition.items,pscSecureRtl)

        #find max leak find in a single path among all the paths.
        pscSecureRtl = PSCSecureRtl(ast,None,reg_decl,width_dict,mapping,decl_stat_dict,fanout_map)    
        new_latency = get_latency(pscSecureRtl)
        
        print_breakline()
        print("New Latency: ",new_latency)    
        print_breakline()
    codegen = ASTCodeGenerator()
    rslt = codegen.visit(ast)

    fptr = open(new_name, 'w')
    print(time_scale+rslt, file=fptr)


if __name__ == '__main__':
    file_name = 'standard_test_files/aes/aes_sbox.v'
    main(file_name=file_name)
