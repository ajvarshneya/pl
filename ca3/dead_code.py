from copy import copy
from tacs import *

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

 	for inst in reversed(block.insts):

 		# Branch/return cases, add to live set
 		if isinstance(inst, TACBt) or isinstance(inst, TACReturn) or isinstance(inst, TACStore):
 			live_set.add(inst.val)

 		# Remove assignee from live set
 		if hasattr(inst, 'assignee'):
 			live_set.discard(inst.assignee)

	 		# Add operands to live set
	 		if hasattr(inst, 'op1'):
	 			live_set.add(inst.op1)
	 		if hasattr(inst, 'op2'):
	 			live_set.add(inst.op2)

	 		live_sets += [copy(live_set)]

 	if block.live_in != live_set:
 		change = True

 	block.live_in = copy(live_set)
 	block.live_sets = copy(live_sets)
 	return change

# Refreshes the liveness sets of blocks by percolating changes
def liveness(blocks):

	change = True # Whether we removed something on last iteration
	while (change):
		change = False

		# Compute/propogate liveness set changes until no change
		for block in blocks:

			# live_out = live_in1 U live_in2 U ...
			for child in block.children:
				block.live_out = block.live_out.union(child.live_in)

			# percolate the live_out changes
			change = change or percolate(block)

def dead_code(blocks):
	# Dead code elimination
	removal = True
	while (removal):
		removal = False

		# Refresh liveness sets of all blocks
		liveness(blocks)

		# Remove dead code
		for block in blocks:
			removal = (removal or kill_dead_code(block))
	return blocks