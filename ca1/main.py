
import sys
class TACAssign(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return 	(str(self.assignee) + ' <- ' + str(self.op1))


class TACPlus(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	(str(self.assignee) + ' <- + ' + str(self.op1) + ' ' + str(self.op2))


class TACMinus(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- - ' + str(self.op1) + ' ' + str(self.op2)


class TACMultiply(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- * ' + str(self.op1) + ' ' + str(self.op2)


class TACDivide(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- / ' + str(self.op1) + ' ' + str(self.op2)


class TACLT(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- < ' + str(self.op1) + ' ' + str(self.op2)


class TACLEQ(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- <= ' + str(self.op1) + ' ' + str(self.op2)


class TACEqual(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) + ' <- = ' + str(self.op1) + ' ' + str(self.op2)


class TACInt(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- int ' + str(self.op1)


class TACBool(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- bool ' + str(self.op1)


class TACString(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- string ' + str(self.op1)


class TACNot(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- not ' + str(self.op1)


class TACNeg(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- ~ ' + str(self.op1)


class TACNew(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- new ' + str(self.op1)


class TACDefault(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- default ' + str(self.op1)


class TACIsVoid(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- isvoid ' + str(self.op1)


class TACOutInt(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- call out_int ' + str(self.op1)


class TACOutString(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- call out_string ' + str(self.op1)


class TACInInt(object):
	def __init__(self, assignee):
		self.assignee = assignee

	def __str__(self):
		return str(self.assignee) + ' <- call in_int'


class TACInString(object):
	def __init__(self, assignee):
		self.assignee = assignee

	def __str__(self):
		return str(self.assignee) + ' <- call in_string'


class TACAbort(object):
	def __init__(self, assignee):
		self.assignee = assignee

	def __str__(self):
		return str(self.assignee) + ' <- call abort'

## LABEL INSTRUCTION DEFINITIONS

class TACJmp(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		return 'jmp ' + str(self.label)


class TACLabel(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		return 'label ' + str(self.label)

class TACReturn(object):
	def __init__(self, ret):
		self.ret = ret

	def __str__(self):
		return 'return ' + str(self.ret)

class TACBt(object):
	def __init__(self, boolean, label):
		self.boolean = boolean
		self.label = label

	def __str__(self):
		return 'bt ' + str(self.boolean) + ' ' + str(self.label)

## BASIC BLOCK DEFINITION

class TACBasicBlock(object):
	def __init__(self, insts):
		self.insts = insts
		self.label = self.insts[0].label

		self.children = []
		self.parents = []

		self.child_labels = [inst.label for inst in self.insts 
							if isinstance(inst, TACJmp) or
							   isinstance(inst, TACBt)]

	def __str__(self):
		s = 'Label : ' + str(self.label) + '\n'
		s += 'Parents : ' + str([parent.label for parent in self.parents]) + '\n'
		for idx, item in enumerate(self.insts):
			s += str(idx) + '. ' + str(item) + '\n'
			s += 'Children : ' + str([child.label for child in self.children]) + '\n'
		return s


def read_tac(filename):
	f = open(filename)
	tac = []
	for line in f:
		tac.append(line.rstrip('\n').rstrip('\r'))
	f.close()
	return tac


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
			inst_list.append(TACLabel(label))

		elif inst[0] == 'bt': # Branch instruction
			boolean = inst[1]
			label = inst[2]
			inst_list.append(TACBt(boolean, label))

		elif inst[0] == 'return': # Return instruction
			ret = inst[1]
			inst_list.append(TACReturn(ret))

		elif inst[0] == 'comment': # Comment instruction
			continue

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
				inst_list.append(TALEQ(assignee, op1, op2))

			elif inst[2] == '=': # Equals instruction
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACEqual(assignee, op1, op2))

			elif inst[2] == 'int': # Integer constant instruction
				op1 = inst[3]
				inst_list.append(TACInt(assignee, op1))

			elif inst[2] == 'bool': # Boolean constant instruction
				op1 = inst[3]
				inst_list.append(TACBool(assignee, op1))
			
			elif inst[2] == 'string': # String constant instruction
				inst = next(tac_iter) # Skip a line
				op1 = inst  # Take first (and only) item
				inst_list.append(TACString(assignee, op1))

			elif inst[2] == 'not': # Boolean negation instruction
				op1 = inst[3]
				inst_list.append(TACNot(assignee, op1))

			elif inst[2] == '~': # Arithmetic negation instruction
				op1 = inst[3]
				inst_list.append(TACNot(assignee, op1))

			elif inst[2] == 'new': # Object allocation instruction
				op1 = inst[3]
				inst_list.append(TACNew(assignee, op1))

			elif inst[2] == 'default': # Default assignment instruction
				op1 = inst[3]
				inst_list.append(TACDefault(assignee, op1))

			elif inst[2] == 'isvoid': # Void check instruction
				op1 = inst[3]
				inst_list.append(TACDefault(assignee, op1))

			elif inst[2] == 'call': # Call instructions
				if inst[3] == 'out_int':
					op1 = inst[4]
					inst_list.append(TACOutInt(assignee, op1))
				if inst[3] == 'out_string':
					op1 = inst[4]
					inst_list.append(TACOutString(assignee, op1))					
				if inst[3] == 'in_int':
					op1 = inst[4]
					inst_list.append(TACInInt(assignee))
				if inst[3] == 'in_string':
					op1 = inst[4]
					inst_list.append(TACInString(assignee))
				if inst[3] == 'abort':
					inst_list.append(TACAbort(assignee))

			else: # Must be an assignment instruction
				op1 = inst[2]
				inst_list.append(TACAssign(assignee, op1))

	return inst_list


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

def liveness(block):
	

def main():
	filename = sys.argv[1]

	tac = read_tac(filename)
	insts = make_inst_list(tac)
	blocks = make_bbs(insts)

	# print ''
	# for block in blocks:
	# 	print (str(block) + '\n')

	# Eliminate dead code
	
	changed = True
	while (changed):
		changed = False

		# 1. Compute liveness for each basic block
		for block in blocks:




if __name__ == '__main__':
	main()