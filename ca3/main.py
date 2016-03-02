import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from dead_code import *

# Generates list of basic blocks given list of TAC objects
def make_bbs(insts):
	blocks = []
	block_insts = []

	# Create list of instruction lists
	for inst in insts:
		if isinstance(inst, TACLabel):
			block_insts += [[]]
		block_insts[-1] += [inst]

	block_dict = {}

	# Create dictionary of labels mapping to blocks
	for block_inst in block_insts:
		new_block = TACBasicBlock(block_inst)

		# Add to list of blocks we can iterate over to generate relationships
		blocks += [new_block]
		block_dict[new_block.label] = new_block

	# Populate parents/children lists of each block
	for block in blocks:
		# Get children
		for child_label in block.child_labels:
			child = block_dict[child_label]
			block.children += [child]

		# Set parent of children
		for child in block.children:
			child.parents += [block]

	return blocks 

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

def main():
	# .cl-type file
	filename = sys.argv[1]

	# Read AST from file
	raw_ast = read_input(filename)

	# Generate AST object
	ast = generate_ast(raw_ast)

	# Generate TAC instructions from AST object
	tacs = tac_ast(ast)

	# Generate basic blocks from TAC instructions
	blocks = make_bbs(tacs)

	# Dead code elimination
	blocks = dead_code(blocks)

	# Register allocation
	# While our virtual registers cannot be fit into the 'k' registers we have (i.e. RIG is not k-colorable):
	# Iterate through basic blocks



	for block in blocks:
		for live_set in block.live_sets:
			if len(live_set) > 11:

	# Assembly generation

	# Print to stdout
	# print "comment start"
	# for block in blocks:
	# 	for inst in block.insts:
	# 		print inst

if __name__ == '__main__':
	main()