from optparse import OptionParser
import os
import random
import sys
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator
from pyverilog.vparser.parser import VerilogCodeParser
import pyverilog.vparser.ast as vast


from utils import get_all_declared_registers, remove_common


def main():
    INFO = "Code converter from AST"
    USAGE = "Usage: python example_codegen.py file -r <REGISTER_FILE>"

    def showVersion():
        print(INFO)
        print(USAGE)
        sys.exit()

    optparser = OptionParser()
    optparser.add_option("-f", "--file", dest="input_file", default="input.v",
                         type=str, help="Name of the input verilog file")
    (options, args) = optparser.parse_args()

    if (not os.path.exists(options.input_file)):
        raise IOError("File not found: " + options.input_file)

    codeparser = VerilogCodeParser([options.input_file],
                                   preprocess_include=None,
                                   preprocess_define=None)

    ast = codeparser.parse()
    # Get module definition
    module_defs = [
        x for x in ast.description.definitions if type(x) == vast.ModuleDef]
    # Enlist the registers to lock and get their widths
    all_regs, out_regs = get_all_declared_registers(module_defs[0])
    all_reg_names = list(map(lambda e: e.name, all_regs))
    out_regs_names = list(map(lambda e: e.name, out_regs))
    all_reg_names = remove_common(all_reg_names, out_regs_names)
    reg_outfile_all = open(options.input_file.split(".")
                           [0]+"_reg_all.txt", 'w')
    print('\n'.join(all_reg_names), file=reg_outfile_all)
    reg_outfile_all.close()
    num_regs = len(all_reg_names)
    # Shuffle for 50%
    random.shuffle(all_reg_names)
    regs_names_50 = all_reg_names[:int(num_regs/2)]
    reg_outfile_50 = open(options.input_file.split(".")[0]+"_reg_50.txt", 'w')
    print('\n'.join(regs_names_50), file=reg_outfile_50)
    reg_outfile_50.close()
    # Shuffle for 25%
    random.shuffle(all_reg_names)
    regs_names_25 = all_reg_names[:int(num_regs/4)]
    reg_outfile_25 = open(options.input_file.split(".")[0]+"_reg_25.txt", 'w')
    print('\n'.join(regs_names_25), file=reg_outfile_25)
    reg_outfile_25.close()


if __name__ == '__main__':
    main()
