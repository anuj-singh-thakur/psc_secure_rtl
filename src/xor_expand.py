import random
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator
from pyverilog.vparser.parser import VerilogCodeParser
import pyverilog.vparser.ast as vast

from utils import NodeVisitor

file_name = 'aes_composite/SubBytes_ny_3.v'
new_name = f"{file_name.split('.v')[0]}_expanded.v"
codeparser = VerilogCodeParser([file_name],
                               preprocess_include=None,
                               preprocess_define=None)

ast = codeparser.parse()


class XorExpander(NodeVisitor):
    def visit_Xor(self, node):
        random_num = random.uniform(1, 100)
        if (random_num < 50):
            print("Expanding an Xor")
            left = node.left
            right = node.right
            new_left = vast.And(left, vast.Unot(right))
            new_right = vast.And(vast.Unot(left), right)
            return vast.Or(new_left, new_right)


xor_expander = XorExpander()
new_ast = xor_expander.visit(ast)

codegen = ASTCodeGenerator()
rslt = codegen.visit(new_ast)

fptr = open(new_name, 'w')
print(rslt, file=fptr)
