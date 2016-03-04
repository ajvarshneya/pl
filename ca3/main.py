import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from basic_blocks import *

def k_color(block):
	rig = block.rig
	coloring = {} # Maps nodes to colors

	# Get sorted list of nodes (fewest to greatest # edges)
	nodes = rig.keys()
	nodes.sort(key=lambda node : len(rig[node]))

	# Colors that can be used
	colors = [0]

	# Init first node, greatest # edges
	current_node = nodes.pop()
	coloring[current_node] = colors[0]

	# Color the nodes, ends when we've popped all the nodes
	while nodes:
		# Get a node
		current_node = nodes.pop()

		# Get the best color for this node
		best_color = -1
		for color in colors:
			is_valid_color = True
			adj_nodes = rig[current_node]

			# Does an adjacent node have this color?
			for adj in adj_nodes:
				if coloring.has_key(adj) and coloring[adj] == color:
					is_valid_color = False

			# No adjacent nodes have the color
			if is_valid_color:
				best_color = color
				break

		# No best color, add a new one to our list of possible colors
		if best_color == -1:
			colors.append(len(colors))
			best_color = colors[-1]

		# Set color of current node
		coloring[current_node] = best_color

	block.coloring = coloring
	return len(colors)

def is_assignee(inst, register):
	if hasattr(inst, 'assignee'):
		if inst.assignee == register:
			return True
	return False

def is_operand(inst, register):
	if hasattr(inst, 'op1'):
		if inst.op1 == register:
			return True
	if hasattr(inst, 'op2'):
		if inst.op2 == register:
			return True
	return False

def spill(block, register, visited):

	visited += [block]

	new_insts = []
	for inst in block.insts:
		if is_operand(inst, register):
			new_insts += [TACLoad(register, register)]
		new_insts += [inst]
		if is_assignee(inst, register):
			new_insts += [TACStore(register)] # Change this to offset at some point with a table

	block.insts = new_insts

	for child in block.children:
		if register in child.live_in and child not in visited:
			spill(child, register, visited)

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

# Original tac implementation
####################################################################
# Reads input file
def read_tac(filename):
	f = open(filename)
	tac = []
	for line in f:
		tac.append(line.rstrip('\n').rstrip('\r'))
	f.close()
	return tac
####################################################################

def main():
	# Original TAC implementation
	####################################################################

	filename = sys.argv[1]

	tac = read_tac(filename) # Get raw instructions
	insts = make_inst_list(tac) # Generate list of TAC objects
	blocks = make_bbs(insts) # Generate list of basic blocks

	####################################################################

	# AST implementation

	# # .cl-type file
	# filename = sys.argv[1]

	# # Read AST from file
	# raw_ast = read_input(filename)

	# # Generate AST object
	# ast = generate_ast(raw_ast)

	# # Generate TAC instructions from AST object
	# tacs = tac_ast(ast)

	# # Generate basic blocks from TAC instructions
	# blocks = make_bbs(tacs)

	# # Dead code elimination, computes liveness sets/ranges
	blocks = dead_code(blocks)
	# blocks = liveness(blocks)
	# # Register allocation

	colors = ['eax', 'ebx', 'ecx', 'edx', 'esi', 'edi', 'e8', 'e9', 'e10', 'e11', 'e12', 'e13', 'e14', 'e15']
	k = len(colors)
	k = 4

	for block in blocks:
		# Refresh liveness
		blocks = liveness(blocks)

		if block.rig:
			# Is it k-colorable?
			if k_color(block) > k:
				# It isn't, we need to spill, register w/ greatest live range

				# Get register with greatest live range
				if block.live_ranges:
					spill_register = max(block.live_ranges, key=block.live_ranges.get)
					spill(block, spill_register, [])

	blocks = liveness(blocks)

	# print TAC
	print "comment start"
	for block in blocks:
		for inst in block.insts:
			print inst

	# for block in blocks:
	# 	print block.coloring

if __name__ == '__main__':
	main()
