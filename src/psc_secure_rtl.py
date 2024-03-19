from pyverilog.ast_code_generator.codegen import ASTCodeGenerator
from pyverilog.vparser.parser import VerilogCodeParser
import pyverilog.vparser.ast as vast

import re
import random
from utils import NodeVisitor,AnnotateMultipliers


time_scale = "`timescale 1 ns / 1 ps\n"
prefix  = "t"
var_cnt = 1


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
                    # node_rvalue = assign_node.right
                    # #pushing bubble from left side variable to right side
                        
                    # if isinstance(node_rvalue.var,vast.Unot):   
                    #     # x = ~y
                    #     assign_node.right.var = self.k_level_visit(node_rvalue.var.right,level)
                    # else:
                    #     # x = y
                    #     assign_node.right.var = self.k_level_visit(vast.Unot(node_rvalue.var),level)
                    assign_node.right.var = self.k_level_visit(vast.Unot(assign_node.right.var),level)
                    new_node = node.right
                else:
                    new_node = node
            else:
                #we have to visit the node.right varible 
                new_node = self.k_level_visit(node.right,level)
                #Now we have to apply one level of bubble pushing

                # if isinstance(new_node,vast.Unot):
                #     # new_node is  ~(node) then we have to remove the ~(not)
                #     new_node = self.visit_Unot(new_node.right,True)
                # else:
                #     # new_node is  (node) then we have to add the ~(not)
                #     new_node = self.visit_Unot(vast.Unot(new_node),True)

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
    def __init__(self,ast,reg_name,reg_decl,width_dict,mapping) -> None:
        self.ast = ast
        self.reg_name = reg_name
        self.reg_decl = reg_decl
        self.width_dict = width_dict
        self.res = {}
        self.mapping = mapping
        self.vis = {}
        self.depth = 0

    def get_new_variable_name(self,var_name):
        global prefix
        global var_cnt

        new_name = prefix + str(var_cnt) + "_" + var_name
        var_cnt+=1
        return new_name

    def copy_subtree(self, node, depth=0):
        #print(node,depth)
        # to get max depth of the subtree
        self.depth = max(self.depth,depth)

        # creating tuple of binary node
        binary_node = (vast.Times,vast.And,vast.Or,vast.Minus,vast.Plus,vast.Xor,vast.Xnor)
        
        if(isinstance(node,vast.Unot)):
            new_node = self.copy_subtree(node.right,depth)
            return vast.Unot(new_node)        
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
            # TODO: how to handle
            return node
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

                new_var_name = self.get_new_variable_name(node.name)
                self.vis[new_var_name] = node.name

                assign_node = self.mapping[node.name]
                assign_right_node = self.copy_subtree(assign_node.right.var,depth)
                assign_left_node = vast.Identifier(new_var_name)
                assign_node = vast.Assign(vast.Lvalue(assign_left_node),vast.Rvalue(assign_right_node))
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
        k = n//2

        selected_indexes = self.select_uniform_indexes(n,k)

        complementCircuit = ComplementCircuit()
        print(n,k,selected_indexes)
        for index in selected_indexes:
            # get the assignment statement based on the key of current index
            node = self.res[keys[index]]
            complement_node = complementCircuit.visit(vast.Unot(node.right.var))
            node.right.var = vast.Unot(complement_node)

    def get_mux_node(self,node,isUnot=False):
        
        #find complement of current node
        complement_node = self.copy_subtree(node,0) # passing initial depth of the subtree as 0
        complementCircuit = ComplementCircuit(self.res)
        complement_node = complementCircuit.visit(vast.Unot(complement_node))
        complement_node = complement_node if(isUnot) else vast.Unot(complement_node)
        #apply bubble pushing into k level among n
        self.k_level_bubble_pushing()
        print("subtree depth",self.depth)
        # for key,value in self.res.items():
        #     print(f"key: {key}, value: {value.right.var}")

        # based on the depth of copied circuit we apply k level bubble pushing
        k = self.depth
        # we can select 1 to k randomly, currently keeping all k level
        complement_node = complementCircuit.k_level_visit(complement_node,k)
    
        # for key,value in complementCircuit.res.items():
        #     print(f"key: {key}, value: {value.right.var}")

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
            condition = vast.Partselect(vast.Identifier(selected_register), vast.IntConst(selected_bit), vast.IntConst(selected_bit))
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

        random_num = random.uniform(1, 100)
        # randomly add true or false case
        if(random_num<50):
            true_case,false_case = false_case,true_case

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
                node.right.var = self.get_mux_node(node_rvalue.var.right,True)
            else:
                    
                #node.right.var = vast.Unot(node_rvalue.var)
                node.right.var = self.get_mux_node(node_rvalue.var)
        
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
    reg_decl = [x for x in reg_decl if isinstance(x, vast.Reg)]

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

        module_children = module_definition.children()
        assign_stat = [x for x in module_children if type(x)==vast.Assign]
        decl_stat = [x for x in module_children if type(x)==vast.Decl]
        decl_stat_dict = {}
        for stat in decl_stat:
            for child in stat.list:
                if(type(child) in (vast.Reg,vast.Wire)):
                    decl_stat_dict[child.name] = child                

        mapping = {}
        for statement in assign_stat:
            key = statement.left.var.name
            mapping[key] = statement

        reg_decl,width_dict = get_declared_register(module_definition)

        # for r in reg_decl:
        #     print(r.name,width_dict[r.name])


        multiplyAnnotator = AnnotateMultipliers(ast)
        ast = multiplyAnnotator.visit(ast)

        try:
            with open(register_file_name, "r") as file:
                lock_register_list = file.readlines()
        except FileNotFoundError:
                print(f"The file '{register_file_name}' is not found. Please make sure the file exists.")
                continue
        
        for reg_name in lock_register_list:
            pscSecureRtl = PSCSecureRtl(ast,reg_name.strip(),reg_decl,width_dict,mapping)
            ast = pscSecureRtl.visit(ast)

            """
                For Each new variable i.e. used during creating a copy of
                subtree, we are adding their declaration based on the old variable
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
                    if type(var)==vast.Reg:
                        new_var = vast.Reg(name=new_var_name,width=var.width,signed=var.signed)
                    else:
                        new_var = vast.Wire(name=new_var_name,width=var.width,signed=var.signed)
                    
                    # finally wrapping the variable as Declared
                    list_of_decl_var.append(vast.Decl([new_var]))
                    decl_stat_dict[new_var_name] = new_var
                else:
                    raise Exception(variable+ " used without declaration...")

            for key,statement in pscSecureRtl.res.items():
                mapping[key] = statement
            
            """
                Finally we are adding modified statements and newly declared variable into 
                Module Definition
            """
            module_definition.items = tuple(list_of_decl_var) + module_definition.items + tuple(list(pscSecureRtl.res.values()))

    codegen = ASTCodeGenerator()
    rslt = codegen.visit(ast)

    fptr = open(new_name, 'w')
    print(time_scale+rslt, file=fptr)


if __name__ == '__main__':
    file_name = 'standard_test_files/waka/waka_no_return.v'
    main(file_name=file_name)

