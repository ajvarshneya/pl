import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from basic_blocks import *
from asm import *
from asm_gen import *
from allocate_registers import *

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

# Writes to output
def write_output(filename, asm):
	f = open(filename[:-8] + ".s", 'w')
	f.write(".section\t.rodata\n")
	f.write(".int_fmt_string:\n")
	f.write("\t.string \"%d\"\n")
	f.write("\t.text\n")
	f.write(".global\tmain\n")
	f.write("\t.type\tmain, @function\n")
	f.write("main:\n")
	for a in asm:
		f.write(str(a) + "\n")
	f.close()

def main():
	# Deserialize AST
	filename = sys.argv[1] 	# .cl-type file
	raw_ast = read_input(filename) 	# Read AST from file
	ast = generate_ast(raw_ast) # Generate AST object
	tacs = tac_ast(ast) # Generate TAC instructions from AST object
	blocks = make_bbs(tacs) # Generate basic blocks from TAC instructions
	blocks = liveness(blocks) # Generate liveness information

	# Register allocation
	allocate_registers(blocks) # Get coloring

	# Generate assembly
	asm = gen_asm(blocks, coloring, spilled_registers)

	# Write to output
	write_output(filename, asm)

if __name__ == '__main__':
	main()
