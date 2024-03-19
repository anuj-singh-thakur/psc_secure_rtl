from __future__ import absolute_import
from __future__ import print_function
from operator import or_, xor
import sys
import os
import random

import pyverilog.vparser.ast as vast
from pyverilog.vparser.ast import Node
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator


class IdentifierData:
    def __init__(self, ast) -> None:
        self.ast = ast
        module_defs = [
            x for x in ast.description.definitions if type(x) == vast.ModuleDef]
        module_definition = module_defs[0]
        module_children = module_definition.children()
        reg_decl = [x for x in module_children if type(x) == vast.Decl]
        reg_decl = [child for x in reg_decl for child in x.children()]
        self.wires = [x for x in reg_decl if isinstance(x, vast.Wire)]
        self.inputs = [x for x in reg_decl if isinstance(x, vast.Input)]
        self.outputs = [x for x in reg_decl if isinstance(x, vast.Output)]

    def get_instance_arguments(self):
        pass


def get_all_reg_input_output_wire(module_definition):
    module_children = module_definition.children()
    reg_decl = [x for x in module_children if type(x) == vast.Decl]
    reg_decl = [child for x in reg_decl for child in x.children()]
    reg_decl = [x for x in reg_decl if isinstance(
        x, (vast.Reg, vast.Input, vast.Output, vast.Wire))]
    return reg_decl


def get_all_declared_registers(module_definition):
    """Finds all registers declared in module

    Args:
        module_definition (vast.ModuleDef): module definition

    Returns:
        reg_decl, out_regs: list of all registers, list of registers that are output
    """
    module_children = module_definition.children()
    reg_decl = [x for x in module_children if type(x) == vast.Decl]
    reg_decl = [child for x in reg_decl for child in x.children()]
    reg_decl = [x for x in reg_decl if isinstance(x, vast.Reg)]

    out_regs = [x for x in module_children if type(x) == vast.Decl]
    out_regs = [child for x in out_regs for child in x.children()]
    out_regs = [x for x in out_regs if isinstance(x, vast.Output)]
    return reg_decl, out_regs


def remove_common(a, b):
    """Set difference between lists a and b

    Args:
        a (list): list of elements
        b (list): list of elements

    Returns:
        _type_: _description_
    """
    new_list = list(set(a) - set(b))
    return new_list


def get_registers(module_definition, reg_file):
    """Open reg file, finds all mentioned registers in verilog and uses
        their widths to find ranges of locking key for each register

    Args:
        module_definition (vast.ModuleDef): Module Definition
        reg_file (str): file name of register file

    Returns:
        reg_decl, width_dict: list of sensitive registers in vast.Reg type, 
                                dictionary mapping reg to part select of locking key
    """
    with open(reg_file, "r") as f:
        reg_names = [line.rstrip('\n \t') for line in f]
    module_children = module_definition.children()
    reg_decl = [x for x in module_children if type(x) == vast.Decl]
    reg_decl = [child for x in reg_decl for child in x.children()]
    reg_decl = [x for x in reg_decl if isinstance(x, vast.Reg)]
    reg_decl = [x for x in reg_decl if x.name in reg_names]
    width_dict = {}
    lsb = vast.IntConst(0)
    msb = reg_decl[0].width.msb if (
        reg_decl[0].width is not None) else vast.IntConst(0)
    lock_width = vast.Partselect(
        vast.Identifier("locking_key"),
        msb,
        lsb
    )
    width_dict[reg_decl[0].name] = lock_width
    for i in range(1, len(reg_decl)):
        lsb = vast.Plus(
            msb,
            vast.IntConst(1)
        )
        msb = vast.Plus(
            lsb,
            reg_decl[i].width.msb
        ) if reg_decl[i].width is not None else lsb
        lock_width = vast.Partselect(
            vast.Identifier("locking_key"),
            msb,
            lsb
        )
        width_dict[reg_decl[i].name] = lock_width
    return reg_decl, width_dict


def add_lock_declaration(module_definition, reg_file):
    """Adds locking key to module inputs and declares it in body of module

    Args:
        module_definition (vast.ModuleDef): module definition
        reg_file (str): name of register file
    """
    reg_list, _ = get_registers(module_definition, reg_file)
    total_width = None
    for i in range(len(reg_list)):
        if reg_list[i].width is not None:
            total_width = vast.Plus(total_width, reg_list[i].width.msb) if (
                total_width is not None) else reg_list[i].width.msb
    surplus = len(reg_list)-1
    if total_width is None:
        total_width = vast.IntConst(0)
    total_width = vast.Plus(total_width, vast.IntConst(surplus))

    org_portlist = list(module_definition.portlist.ports)
    # org_portlist.append(
    #     vast.Ioport(vast.Input("locking_key", vast.Width(total_width, vast.IntConst(0)))))
    org_portlist.append(vast.Port("locking_key", None, None, None))
    module_items = list(module_definition.items)
    locking_key_port_decl = vast.Input(
        "locking_key",
        vast.Width(total_width,
                   vast.IntConst(0)))
    module_items.insert(0, vast.Decl((locking_key_port_decl,)))
    module_definition.items = tuple(module_items)
    module_definition.portlist = vast.Portlist(org_portlist)


def ischild(node, attr):
    if not isinstance(node, Node):
        return False
    excludes = ('coord', 'attr_names',)
    if attr.startswith('__'):
        return False
    if attr in excludes:
        return False
    attr_names = getattr(node, 'attr_names')
    if attr in attr_names:
        return False
    attr_test = getattr(node, attr)
    if hasattr(attr_test, '__call__'):
        return False
    return True


def children_items(node):
    children = [attr for attr in dir(node) if ischild(node, attr)]
    ret = []
    for c in children:
        ret.append((c, getattr(node, c)))
    return ret


class NodeVisitor(object):

    def visit(self, node):
        method = 'visit_' + node.__class__.__name__
        visitor = getattr(self, method, self.generic_visit)
        ret = visitor(node)
        if ret is None:
            return node
        return ret

    def generic_visit(self, node):
        for name, child in children_items(node):
            ret = None
            if child is None:
                continue
            if (isinstance(child, list) or isinstance(child, tuple)):
                r = []
                for c in child:
                    r.append(self.visit(c))
                ret = tuple(r)
            else:
                ret = self.visit(child)
            setattr(node, name, ret)
        return node


class XorBeforeRead(NodeVisitor):
    """All instances of sensitive registers are XORed and NOT is added. 
        reg_a ---> ~(reg_a ^ key)
        Sets attribute "do_not_push" since this NOT gate should not be pushed 
        back. This NOT gate is the result of pushing forward at a register. 

    Args:
        NodeVisitor (class): Base class for DFS visitor
    """

    def __init__(self, lock_partselects):
        self.lock_partselects = lock_partselects

    def visit_Identifier(self, node):
        if node.name in self.lock_partselects:
            new_id = vast.Unot(
                vast.Xor(
                    vast.Identifier(node.name),
                    self.lock_partselects[node.name]
                )
            )
            setattr(new_id, "do_not_push", True)
            return new_id
        return node


class BackPush(NodeVisitor):

    def __init__(self, ast) -> None:
        super().__init__()
        self.bubble_regs = set()
        module_defs = [
            x for x in ast.description.definitions if type(x) == vast.ModuleDef]
        all_regs = get_all_reg_input_output_wire(module_defs[0])
        self.input_ports = [
            inp for inp in all_regs if isinstance(inp, vast.Input)]
        self.input_ports = [port.name for port in self.input_ports]

    def print_bubble_push(self, node_str, vast_node=None):
        print(f"Bubble pushed across {node_str}")
        if (vast_node is not None):
            code_gen = ASTCodeGenerator()
            rtl_line = code_gen.visit(vast_node)
            print(f"\t\t{rtl_line}")

    def clear_bubble_regs(self):
        self.bubble_regs.clear()

    def visit_Unot(self, node):
        # Ensure NOT gates are selected randomly
        random_num = random.uniform(1, 100)
        if (random_num < 50):
            return node
        if (hasattr(node, "do_not_push")):
            if (getattr(node, "do_not_push") == True):
                pass
        # OR gate
        elif (isinstance(node.right, vast.Or)):
            or_operation = self.visit(node.right)
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
            self.print_bubble_push("OR", node)
        # AND gate
        elif (isinstance(node.right, vast.And)):
            and_operation = self.visit(node.right)
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
            self.print_bubble_push("AND", node)
        # PLUS operation
        elif (isinstance(node.right, vast.Plus)):
            plus_op = self.visit(node.right)
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
            self.print_bubble_push("ADDER", node)
        # MUL operation
        elif (isinstance(node.right, vast.Times)):
            lhs_width = None
            if (hasattr(node.right, "left_shift")):
                lhs_width = getattr(node.right, "left_shift")
            else:
                raise Exception("Multiply used without left_shift attribute")
            if (lhs_width is None):
                shift_value = vast.IntConst(1)
            else:
                shift_value = vast.Plus(
                    lhs_width.msb,
                    vast.IntConst(1)
                )
            mul_op = self.visit(node.right)
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
            new_op = vast.Plus(
                vast.Minus(
                    add_part,
                    mul_part
                ),
                add_part2
            )
            node = new_op
            self.print_bubble_push("MULTIPLIER", node)
        # TERNARY Operator
        elif (isinstance(node.right, vast.Cond)):
            tern_op = self.visit(node.right)
            condition = tern_op.cond
            false_val = vast.Unot(tern_op.false_value)
            true_val = vast.Unot(tern_op.true_value)
            new_node = vast.Cond(
                condition,
                true_val,
                false_val
            )
            node = new_node
            self.print_bubble_push("TERNARY OPERATOR", node)
        # SUBTRACTOR
        elif (isinstance(node.right, vast.Minus)):
            sub_op = self.visit(node.right)
            sub_left = sub_op.left
            sub_right = sub_op.right
            new_op = vast.Unot(
                vast.Minus(
                    vast.Unot(sub_right),
                    vast.Unot(sub_left)
                )
            )
            node = new_op
            self.print_bubble_push("SUBTRACTOR", node)
        # XOR gate
        elif (isinstance(node.right, vast.Xor)):
            xor_op = self.visit(node.right)
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
            self.print_bubble_push("XOR", node)
        elif (isinstance(node.right, vast.Identifier)):
            if (node.right.name not in self.input_ports):
                print(f"Bubble stuck before Identifier = {node.right.name}")
                self.bubble_regs.add(node.right.name)
        elif (isinstance(node.right, (vast.Pointer, vast.Partselect))):
            if (node.right.var.name not in self.input_ports):
                print(
                    f"Bubble stuck before Identifier = {node.right.var.name}")
                self.bubble_regs.add(node.right.var.name)
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
                self.print_bubble_push("$signed", node)
        # CONCAT operator
        elif (isinstance(node.right, vast.Concat)):
            node_right = node.right
            new_concat_list = []
            for child in node_right.list:
                new_concat_list.append(vast.Unot(child))
            new_node = vast.Concat(new_concat_list)
            node = new_node
            self.print_bubble_push("Concat", node)
        else:
            new_right = self.visit(node.right)
            node = vast.Unot(new_right)

        return node


class RegOutputBubble(NodeVisitor):
    """If output line of register has NOT then remove it. 
        If output of register does not have NOT then add it. 
        Assumes NotRHS is run before this function as LHS has to be 
        attributed with "is_lhs"

    Args:
        NodeVisitor (class): Base class for DFS
    """

    def __init__(self, reg_name, pre_bubble_push=False) -> None:
        self.reg_name = reg_name
        self.pre_bubble_push = pre_bubble_push

    def visit_Unot(self, node):
        node_right = node.right
        if (isinstance(node_right, vast.Identifier)):
            if (node_right.name == self.reg_name):
                return node_right
        elif (isinstance(node.right, (vast.Pointer, vast.Partselect))):
            if (node_right.var.name == self.reg_name):
                return node_right
        node.right = self.visit(node.right)
        return node

    def visit_Pointer(self, node):
        if (node.var.name == self.reg_name):
            if (hasattr(node, "is_lhs") and getattr(node, "is_lhs") == True):
                return node
            else:
                return self.get_not_node(node)

        return node

    def visit_Partselect(self, node):
        if (node.var.name == self.reg_name):
            if (self.is_node_lhs(node)):
                return node
            else:
                return self.get_not_node(node)
        else:
            return node

    def visit_Pointer(self, node):
        if (node.var.name == self.reg_name):
            if (self.is_node_lhs(node)):
                return node
            else:
                return self.get_not_node(node)
        else:
            return node

    def is_node_lhs(self, node):
        if (hasattr(node, "is_lhs") and getattr(node, "is_lhs") == True):
            return True
        return False

    def get_not_node(self, node):
        new_node = vast.Unot(node)
        if (self.pre_bubble_push):
            setattr(new_node, "do_not_push", True)
        return new_node

    def visit_Identifier(self, node):
        if (node.name == self.reg_name):
            if (self.is_node_lhs(node)):
                return node
            else:
                return self.get_not_node(node)
        else:
            return node


class NotRHS(NodeVisitor):
    """Adds (~)NOT to RHS of given register name at all assign and substitution statements
        Also sets attribute "is_lhs" to vast.Identifier on LHS so that NOT gates are not 
        added to LHS.

    Args:
        NodeVisitor (_type_): _description_
    """

    def __init__(self, reg_name) -> None:
        self.reg_name = reg_name

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
            node_rvalue = node.right
            # If it is of the form "x = ~y", then remove the not
            if (isinstance(node_rvalue.var, vast.Unot)):
                node.right.var = node_rvalue.var.right
            else:
                node.right.var = vast.Unot(node_rvalue.var)
        # Annotate LHS values to avoid adding NOT gate infront of them
        setattr(node.left.var, "is_lhs", True)
        return node

    def visit_Assign(self, node):
        return self.visit_AnyAssignment(node)

    def visit_NonblockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)

    def visit_BlockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)


class AnnotateMultipliers(NodeVisitor):

    def __init__(self, ast) -> None:
        super().__init__()
        module_defs = [
            x for x in ast.description.definitions if type(x) == vast.ModuleDef]
        all_regs = get_all_reg_input_output_wire(module_defs[0])
        self.widths = {}
        for reg in all_regs:
            self.widths[reg.name] = reg.width

    def contains_multiply(self, node):
        if (isinstance(node, vast.Times)):
            return True
        for child in node.children():
            if (self.contains_multiply(child)):
                return True
        return False

    def annotate_multiply(self, node, width):
        if (isinstance(node, vast.Times)):
            setattr(node, "left_shift", width)
        else:
            for child in node.children():
                self.annotate_multiply(child, width)

    def visit_AnyAssignment(self, node):
        if (self.contains_multiply(node)):
            reg_name = None
            if (isinstance(node.left, vast.Pointer)):
                reg_name = node.left.var.var.name
            else:
                reg_name = node.left.var.name
            width = self.widths[reg_name]
            self.annotate_multiply(node, width)
        return node

    def visit_Assign(self, node):
        return self.visit_AnyAssignment(node)

    def visit_NonblockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)

    def visit_BlockingSubstitution(self, node):
        return self.visit_AnyAssignment(node)


def lock_rhs(item, regs, partselects):
    """Locks the RHS of statements containing sensitive register on LHS
        reg_a = x  ---> reg_a_REPLACE = ~(x^key)
        IMPORTANT: For each such statement, it changes the LHS reg name to <reg>_REPLACE
            This is done to prevent adding XOR to LHS when vast.Identifier nodes are modified
            using XorBeforeRead()

    Args:
        item (vast.Node): AST node
        regs (list[vast.Identifier]): list of sensitive registers 
        partselects (dictionary): dictionary mapping sensitive register to range(partselect) of locking_key
    """
    if isinstance(item, (vast.Assign, vast.NonblockingSubstitution, vast.BlockingSubstitution)):
        if (item.left.var in regs):
            original_right = item.right
            new_right = vast.Unot(
                vast.Xor(
                    original_right.var,
                    partselects[item.left.var.name]
                )
            )
            item.right = vast.Rvalue(
                new_right
            )
            item.left.var.name = item.left.var.name+"_REPLACE"

    if (len(item.children()) == 0):
        return
    for index, child in enumerate(item.children()):
        lock_rhs(child, regs, partselects)


def remove_added_suffix(item):
    """In lock_rhs, every LHS sensitive register is renamed to <reg>_REPLACE. In this function
        we remove the locations where _REPLACE is added. 

    Args:
        item (vast.Node): AST Node
    """
    if isinstance(item, (vast.Assign, vast.NonblockingSubstitution, vast.BlockingSubstitution)):
        if ("_REPLACE" in item.left.var.name):
            item.left.var.name = item.left.var.name.replace("_REPLACE", "")

    if (len(item.children()) == 0):
        return
    for index, child in enumerate(item.children()):
        remove_added_suffix(child)
