import sys
from tacs import *
from tacs_gen import *
from basic_blocks import *

NUM_COLORS = 14 # Number of registers
spilled_registers = []
coloring = {}

def get_color(register, size=64):
	global coloring
	colors32 = ['%r8d', '%r9d', '%r10d', '%r11d', '%r12d', '%r13d', '%r14d', '%r15d', '%eax', '%ebx', '%ecx', '%edx', '%esi', '%edi']
	colors64 = ['%r8', '%r9', '%r10', '%r11', '%r12', '%r13', '%r14', '%r15', '%rax', '%rbx', '%rcx', '%rdx', '%rsi', '%rdi']
	if size == 64:
		return str(colors64[int(coloring[register])])
	if size == 32:
		return str(colors32[int(coloring[register])])
	raise ValueError("Size is neither 32 nor 64.")

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

			# Add the current instruction
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
		if node_to_remove in live_ranges:
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
		# compute_edges(graph)
		done = spill_and_fill(blocks, live_ranges, graph)

def compute_edges(graph):
	num = 0
	for k in graph:
		for v in graph[k]:
			num += 1
	print num

# Computes register interference graph
def get_graph(blocks):
	graph = {}
	for block in blocks:
		# Iterate through live sets in each block
		for inst, live_set in zip(block.insts, block.live_sets):
			
			assignee = None
			if hasattr(inst, 'assignee'):
				assignee = inst.assignee

				if assignee not in graph:
					graph[assignee] = set()

			live_list = list(live_set)

			# Add an edge between every two elements in the live sets in the graph (excluding self edges)
			for i in range(0, len(live_list)):
				reg1 = live_list[i]

				if reg1 not in graph:
					graph[reg1] = set()

				for j in range(i+1, len(live_list)):
					reg2 = live_list[j]

					if reg2 not in graph:
						graph[reg2] = set()

					graph[reg1].add(reg2)
					graph[reg2].add(reg1)

				if assignee != None and reg1 != assignee:
					graph[assignee].add(reg1)
					graph[reg1].add(assignee)

	return graph

# Approximates live ranges in blocks
def get_live_ranges(blocks):
	live_ranges = {}
	for block in blocks:
		for register in block.live_ranges:

			# Add register to dictionary if not yet encountered
			if register not in live_ranges:
				live_ranges[register] = 0

			# Add to already computed live range approximation
			live_ranges[register] += block.live_ranges[register]

	return live_ranges