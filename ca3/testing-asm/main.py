import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from basic_blocks import *
from asm import *
from asm_gen import *

NUM_COLORS = 14 # Number of registers
spilled_registers = []
coloring = {}

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

def color(registers_to_color, graph):
	global coloring

	# Colors that can be used
	colors = [0]

	while registers_to_color:
		register = registers_to_color.pop()

		# Get the best color for this register
		best_color = -1
		for color in colors:
			is_valid_color = True
			adj_nodes = graph[register]

			# Does an adjacent node have this color?
			for adj_node in adj_nodes:
				if adj_node in coloring and coloring[adj_node] == color:
					is_valid_color = False

			# No adjacent nodes have the color
			if is_valid_color:
				best_color = color
				break

		# Couldn't find a best color, make one up
		if best_color == -1:
			colors.append(len(colors))
			best_color = colors[-1]

		# Set color of the register
		coloring[register] = best_color

def spill(blocks, register):
	# Add register to our global list of spilled registers
	global spilled_registers
	spilled_registers += [register]

	for block in blocks:
		# Build new list of instructions with loads/stores added as necessary
		new_insts = []
		for inst in block.insts:
			# Add load above current instruction where register is an operand
			if is_operand(inst, register):
				new_insts += [TACLoad(register, len(spilled_registers))]

			# Add the current instruciton
			new_insts += [inst]

			# Add a store below current instruction where register is the assignee
			if is_assignee(inst, register):
				new_insts += [TACStore(register)]

		# Update block with new instructions
		block.insts = new_insts

def spill_and_fill(blocks, original_live_ranges, original_graph):
	global NUM_COLORS

	# Operate on copies of graph, live_ranges
	graph = copy(original_graph)
	live_ranges = copy(original_live_ranges)

	registers_to_color = []
	registers_to_spill = []

	# Construct a list of nodes to color and a list of nodes to spill
	while graph:
		# Find a node with fewer than k edges to color
		node_to_remove = None
		for node in graph.keys():
			if len(graph[node]) < NUM_COLORS:
				node_to_remove = node
				break;

		if node_to_remove:
			# Add to coloring list
			registers_to_color += [node_to_remove]
		else:
			# Can't find a node to color, spill the one with longest live range
			node_to_remove = max(live_ranges, key=live_ranges.get)
			registers_to_spill += [node_to_remove]

		# Remove node from graph, continue
		adj_nodes = graph.pop(node_to_remove)
		for adj_node in adj_nodes:
			graph[adj_node].discard(node_to_remove)

		# Remove node from live_ranges
		live_ranges.pop(node_to_remove)

	# Spill registers that we couldn't color at each step of reduction
	for register in registers_to_spill:
		spill(blocks, register)

	# If we spilled, don't color, otherwise color
	if registers_to_spill:
		return False
	else:
		color(registers_to_color, original_graph)
		return True

# Computes mapping between virtual registers and physical registers, using stack as needed
def allocate_registers(blocks):
	done = False
	while not done:
		blocks = liveness(blocks)
		live_ranges = get_live_ranges(blocks) # Generate live ranges of virtual registers
		graph = get_graph(blocks) # Generate register interference graph
		done = spill_and_fill(blocks, live_ranges, graph)

# Computes register interference graph
def get_graph(blocks):
	graph = {}
	for block in blocks:
		# Iterate through live sets in each block
		for live_set in block.live_sets:
			# Add an edge between every two elements in the live sets in the graph (excluding self edges)
			for r1 in live_set:
				if r1 not in graph:
					graph[r1] = set()
				for r2 in live_set:
					if r1 != r2:
						if r2 not in graph:
							graph[r2] = set()
						graph[r1].add(r2)
						graph[r2].add(r1)
	return graph

# Computes the live ranges for our set of blocks
def get_live_ranges(blocks):
	live_ranges = {}
	for block in blocks:
		for live_set in block.live_sets:
		 	for register in live_set:
		 		if register in live_ranges:
		 			live_ranges[register] += 1
		 		else:
		 			live_ranges[register] = 1
	return live_ranges

# Reads in raw input (FOR AST DESERIALIZATION)
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

	# Eliminate deadcode, compute liveness information
	blocks = dead_code(blocks)
	# blocks = liveness(blocks)

	# for block in blocks:
	# 	print block

	# for block in blocks:
	# 	for inst, ls in zip(block.insts, block.live_sets):
	# 		print inst, "\t", ls

	# Register allocation
	allocate_registers(blocks) # Get coloring

	# Generate assembly
	asm = gen_asm(blocks, coloring, spilled_registers)

	# Write to output
	write_output(filename, asm)

if __name__ == '__main__':
	main()
