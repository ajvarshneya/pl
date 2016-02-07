import sys

class TACLabel(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		return 'label ' + str(self.label)


class TACJmp(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		return 'jmp ' + str(self.label)


class TACBt(object):
	def __init__(self, boolean, label):
		self.boolean = boolean
		self.label = label

	def __str__(self):
		return 'bt ' + str(self.boolean) + ' ' + str(self.label)


class TACPlus(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- + ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACMinus(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- - ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACMultiply(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- * ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACDivide(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- / ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACLT(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- < ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACLEQ(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- <= ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACEqual(object):
	def __init__(self, assignee, op1, op2):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		return 	str(self.assignee) +
				' <- = ' +
				str(self.op1) +
				' ' +
				str(self.op2)


class TACBasicBlock(object):
	def __init__(self, insts):
		self.insts = insts
		self.label = self.insts[0].label

		self.children = []
		self.parents = []

		self.child_labels = [inst.label for inst in self.insts 
							if isInstance(inst, TACJmp) or
							   isInstance(inst, TACBt)]

	def __str__(self):
		s = 'Label : ' + str(self.label) + '\n'
		s += 'Parents : ' + str([parent.label for parent in self.parents]) + '\n'
		for idx, item in enumerate(self.insts):
			s += str(idx) + '. ' + str(item) + '\n'
			s += 'Children : ' + str([child.label for child in self.children]) + '\n'
		return s


def make_bbs(insts):
	blocks = []
	blocked_insts = []

	# Create list of instruction lists
	for inst in insts:
		if isInstance(inst, TACLabel):
			blocked_insts += [[]]
		blocked_insts[-1] += [instruction]

	block_dict = {}

	# Create dictionary of labels mapping to blocks
	for block in blocked_insts:
		new_block = TACBasicBlock(block)
		blocks += [new_block]
		block_dict[new_block.label] = new_block


def make_inst_list(tac):
	inst_list = []
	for tac_inst in tac:
		inst = tac_inst.split(' ');
		if inst[0] == 'label':
			label = inst[1]
			inst_list.append(TACLabel(label))
		elif inst[0] == 'jmp':
			label = inst[1]
			inst_list.append(TACLabel(label))
		elif inst[0] == 'bt':
			boolean = inst[1]
			label = inst[2]
			inst_list.append(TACBt(boolean, label))
		elif inst[0] == 'return':
			ret = inst[1]
			pass
		elif inst == 'comment':
			pass
		else:
			if inst[2] == '+':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACPlus(assignee, op1, op2))
			if inst[2] == '-':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACMinus(assignee, op1, op2))
			if inst[2] == '*':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACMultiply(assignee, op1, op2))
			if inst[2] == '/':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACDivide(assignee, op1, op2))
			if inst[2] == '<':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACLT(assignee, op1, op2))
			if inst[2] == '<=':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TALEQ(assignee, op1, op2))
			if inst[2] == '=':
				assignee = inst[0]
				op1 = inst[3]
				op2 = inst[4]
				inst_list.append(TACEqual(assignee, op1, op2))


def read_tac(filename):
	f = open(filename)
	tac = []
	for line in f:
		tac.append(line.rstrip('\n').rstrip('\r'))
	f.close()
	return tac


def main():
	filename = sys.argv[1]

	tac = read_tac(filename)
	insts = make_inst_list(tac)
	bbs = make_bbs(insts)


if __name__ == '__main__':
	main()