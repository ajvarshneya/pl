from copy import copy
from tacs import *

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

# Metal function names... this removes the dead code
def kill_dead_code(block):
	removal = False
	live_set = copy(block.live_out)

 	for inst in reversed(block.insts[:]):

 		# Branch/return cases, add to live set
 		if isinstance(inst, TACBt) or isinstance(inst, TACReturn):
 			live_set.add(inst.val)

 		# Assignee cases, remove assignee from live set
 		if hasattr(inst, 'assignee'):
 			if (inst.assignee in live_set) or hasattr(inst, 'call'):
  				live_set.discard(inst.assignee)
  				
		 		if hasattr(inst, 'op1'):
		 			live_set.add(inst.op1)
		 		if hasattr(inst, 'op2'):
		 			live_set.add(inst.op2)
		 	else:
		 		block.insts.remove(inst)
		 		removal = True

 	block.live_in = copy(live_set)
 	return removal

# Percolate live_out set up the block
def percolate(block):

	change = False

	live_sets = []

	# Copy so that we don't overwrite live_out
	live_set = copy(block.live_out)
	live_ranges = {}

 	for inst in reversed(block.insts):

 		# Branch/return/store cases, add to live set
 		if isinstance(inst, TACBt) or isinstance(inst, TACReturn):
 			live_set.add(inst.val)

 		if isinstance(inst, TACStore):
 			live_set.add(inst.op1)

 		# Remove assignee from live set
 		if hasattr(inst, 'assignee'):
 			live_set.discard(inst.assignee)

	 		# Add operands to live set
	 		if hasattr(inst, 'op1'):
	 			live_set.add(inst.op1)
	 		if hasattr(inst, 'op2'):
	 			live_set.add(inst.op2)

	 	for t in live_set:
	 		if t in live_ranges:
	 			live_ranges[t] += 1
	 		else:
	 			live_ranges[t] = 1

	 	live_sets += [copy(live_set)]

	# print live_set

 	if block.live_in != live_set:
 		change = True

 	live_sets.reverse()

 	rig = {}
	for ls in live_sets:
		for r1 in ls:
			for r2 in ls:
				if r1 != r2:
					if r1 not in rig:
						rig[r1] = set()
					if r2 not in rig:
						rig[r2] = set()
					rig[r1].add(r2)
					rig[r2].add(r1)

	block.rig = copy(rig)
	block.live_in = copy(live_set)
 	block.live_sets = copy(live_sets)
 	block.live_ranges = copy(live_ranges)

 	return change

# Refreshes the liveness sets of blocks by percolating changes
def liveness(blocks):

	change = True # Whether we removed something on last iteration
	while (change):
		change = False

		# Compute/propogate liveness set changes until no change
		for block in blocks:
			live_out = set()

			# live_out = live_in1 U live_in2 U ...
			for child in block.children:
				live_out = live_out.union(child.live_in)

			block.live_out = live_out

			# percolate the live_out changes
			change = change or percolate(block)

	return blocks

def dead_code(blocks):
	# Dead code elimination
	removal = True
	while (removal):
		removal = False

		# Refresh liveness sets of all blocks
		blocks = liveness(blocks)

		# Remove dead code
		for block in blocks:
			removal = (removal or kill_dead_code(block))
	return blocks

# Original TAC
########################################################################

# Generates list of TAC instruction objects given instructions
def make_inst_list(tac):
	inst_list = []
	tac_iter = iter(tac)

	for tac_inst in tac_iter:
		inst = tac_inst.split(' ');
		if inst[0] == 'label': # Label instruction
			label = inst[1]
			inst_list.append(TACLabel(label))

		elif inst[0] == 'jmp': # Jump instruction
			label = inst[1]
			inst_list.append(TACJmp(label))

		elif inst[0] == 'bt': # Branch instruction
			val = inst[1]
			label = inst[2]
			inst_list.append(TACBt(val, label))

		elif inst[0] == 'return': # Return instruction
			val = inst[1]
			inst_list.append(TACReturn(val))

		elif inst[0] == 'comment': # Comment instruction
			continue # Skip

		else:
			assignee = inst[0]
			if inst[2] == '+': # Add instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACPlus(assignee, op1, op2))

			elif inst[2] == '-': # Subtract instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACMinus(assignee, op1, op2))

			elif inst[2] == '*': # Multiply instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACMultiply(assignee, op1, op2))

			elif inst[2] == '/': # Divide instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACDivide(assignee, op1, op2))

			elif inst[2] == '<': # Less than instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACLT(assignee, op1, op2))

			elif inst[2] == '<=': # Less than equal to instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACLEQ(assignee, op1, op2))

			elif inst[2] == '=': # Equals instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACEqual(assignee, op1, op2))

			elif inst[2] == 'int': # Integer constant instruction
				val = inst[3]
				inst_list.append(TACInt(assignee, val))

			elif inst[2] == 'bool': # Boolean constant instruction
				val = inst[3]
				inst_list.append(TACBool(assignee, val))
			
			elif inst[2] == 'string': # String constant instruction
				val = next(tac_iter) # Skip a line
				inst_list.append(TACString(assignee, val))

			elif inst[2] == 'not': # Boolean negation instruction
				op1 = inst[3]
				inst_list.append(TACNot(assignee, op1))

			elif inst[2] == '~': # Arithmetic negation instruction
				op1 = inst[3]
				inst_list.append(TACNot(assignee, op1))

			elif inst[2] == 'new': # Object allocation instruction
				c_type = inst[3]
				inst_list.append(TACNew(assignee, c_type))

			elif inst[2] == 'default': # Default assignment instruction
				c_type = inst[3]
				inst_list.append(TACDefault(assignee, c_type))

			elif inst[2] == 'isvoid': # Void check instruction
				op1 = inst[3]
				inst_list.append(TACIsVoid(assignee, op1))

			elif inst[2] == 'call': # Call instructions
				if inst[3] == 'out_int':
					op1 = inst[4]
					inst_list.append(TACOutInt(assignee, op1))
				if inst[3] == 'out_string':
					op1 = inst[4]
					inst_list.append(TACOutString(assignee, op1))					
				if inst[3] == 'in_int':
					inst_list.append(TACInInt(assignee))
				if inst[3] == 'in_string':
					inst_list.append(TACInString(assignee))
				if inst[3] == 'abort':
					inst_list.append(TACAbort(assignee))

			else: # Must be an assignment instruction
				op1 = inst[2]
				inst_list.append(TACAssign(assignee, op1))

	return inst_list