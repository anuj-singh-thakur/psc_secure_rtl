from __future__ import absolute_import
from __future__ import print_function
import enum
from re import A
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator
from pyverilog.vparser.parser import VerilogCodeParser
import sys
import os
import random
from optparse import OptionParser
from utils import AnnotateMultipliers, RegOutputBubble, get_all_declared_registers, get_registers, XorBeforeRead, add_lock_declaration, BackPush, NotRHS, lock_rhs, remove_added_suffix
import pyverilog.vparser.ast as vast

time_scale = "`timescale 1 ns / 1 ps\n"


def main():
    INFO = "Code converter from AST"
    USAGE = "Usage: python example_codegen.py file -r <REGISTER_FILE>"

    def showVersion():
        print(INFO)
        print(USAGE)
        sys.exit()

    optparser = OptionParser()
    optparser.add_option("-r", "--registers", dest="register_file", default="reg.txt",
                         type=str, help="Name of the file containing registers to lock")
    optparser.add_option("-f", "--file", dest="input_file", default="input.v",
                         type=str, help="Name of the input verilog file")
    optparser.add_option("-i", "--iter", dest="num_iterations", default=10,
                         type=int, help="Number of interations of bubble pushing")
    (options, args) = optparser.parse_args()

    if (not os.path.exists(options.input_file)):
        raise IOError("File not found: " + options.input_file)
    if (not os.path.exists(options.register_file)):
        raise IOError("File not found: " + options.register_file)

    codeparser = VerilogCodeParser([options.input_file],
                                   preprocess_include=None,
                                   preprocess_define=None)

    ast = codeparser.parse()
    # Get module definition
    module_defs = [
        x for x in ast.description.definitions if type(x) == vast.ModuleDef]
    # Enlist the registers to lock and get their widths
    required_regs, reg_partselect = get_registers(
        module_defs[0], options.register_file)

    # Add bubbles before and after sensitive registers
    for sensitive_reg in required_regs:
        notRHS = NotRHS(sensitive_reg.name)
        ast = notRHS.visit(ast)
        removeNot = RegOutputBubble(sensitive_reg.name, pre_bubble_push=True)
        ast = removeNot.visit(ast)
    multiplyAnnotator = AnnotateMultipliers(ast)
    ast = multiplyAnnotator.visit(ast)
    # Generate the verilog file
    codegen = ASTCodeGenerator()
    outfile = open(options.input_file.split(".")[0]+"_initial.v", 'w')
    rslt = codegen.visit(ast)
    # Bubble Pushing
    bubble_push = BackPush(ast)
    ast2 = ast
    for iter in range(options.num_iterations):
        print(f"BUBBLE PUSH ITERATION {iter}")
        bubble_push.clear_bubble_regs()
        ast2 = bubble_push.visit(ast2)
        rslt2 = codegen.visit(ast2)
        outfile2 = open(
            "Intermediates/"+options.input_file.split(".")[0]+f"_iter{iter}_bubble.v", 'w')
        print(time_scale + rslt2, file=outfile2)
        for reg in bubble_push.bubble_regs:
            random_number = random.uniform(1, 100)
            if (random_number > 50):
                print(f"Bubble pushing through register {reg}")
                notRHS = NotRHS(reg)
                ast2 = notRHS.visit(ast2)
                removeNot = RegOutputBubble(reg)
                ast2 = removeNot.visit(ast2)
        rslt2 = codegen.visit(ast2)
        outfile2 = open(
            "Intermediates/"+options.input_file.split(".")[0]+f"_iter{iter}.v", 'w')
        print(time_scale+rslt2, file=outfile2)
    rslt2 = codegen.visit(ast2)
    outfile2 = open(options.input_file.split(".")[0]+"_bubble.v", 'w')
    print(time_scale+rslt, file=outfile)
    print(time_scale+rslt2, file=outfile2)


if __name__ == '__main__':
    main()
