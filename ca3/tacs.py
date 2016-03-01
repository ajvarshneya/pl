import copy

# Arithmetic instructions
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

# Comparison instructions
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

# Constant assignment instructions
class TACInt(object):
	def __init__(self, assignee, val):
		self.assignee = assignee
		self.val = val

	def __str__(self):
		return str(self.assignee) + ' <- int ' + str(self.val)

class TACBool(object):
	def __init__(self, assignee, val):
		self.assignee = assignee
		self.val = val

	def __str__(self):
		return str(self.assignee) + ' <- bool ' + str(self.val)

class TACString(object):
	def __init__(self, assignee, val):
		self.assignee = assignee
		self.val = val

	def __str__(self):
		return str(self.assignee) + ' <- string' + '\n' + str(self.val)

# Boolean NOT instruction
class TACNot(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- not ' + str(self.op1)

# Integer negation instruction
class TACNeg(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- ~ ' + str(self.op1)

# New object instruction
class TACNew(object):
	def __init__(self, assignee, c_type):
		self.assignee = assignee
		self.c_type = c_type

	def __str__(self):
		return str(self.assignee) + ' <- new ' + str(self.c_type)

# Default assignment instruction
class TACDefault(object):
	def __init__(self, assignee, c_type):
		self.assignee = assignee
		self.c_type = c_type

	def __str__(self):
		return str(self.assignee) + ' <- default ' + str(self.c_type)

# isvoid instruction
class TACIsVoid(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- isvoid ' + str(self.op1)

# Function call instructions (I/O)
class TACOutInt(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1
		self.call = True

	def __str__(self):
		return str(self.assignee) + ' <- call out_int ' + str(self.op1)


class TACOutString(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1
		self.call = True

	def __str__(self):
		return str(self.assignee) + ' <- call out_string ' + str(self.op1)


class TACInInt(object):
	def __init__(self, assignee):
		self.assignee = assignee
		self.call = True

	def __str__(self):
		return str(self.assignee) + ' <- call in_int'


class TACInString(object):
	def __init__(self, assignee):
		self.assignee = assignee
		self.call = True

	def __str__(self):
		return str(self.assignee) + ' <- call in_string'


class TACAbort(object):
	def __init__(self, assignee):
		self.assignee = assignee
		self.call = True

	def __str__(self):
		return str(self.assignee) + ' <- call abort'

# Label instructions

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
	def __init__(self, val):
		self.val = val

	def __str__(self):
		return 'return ' + str(self.val)

class TACBt(object):
	def __init__(self, val, label):
		self.val = val
		self.label = label

	def __str__(self):
		return 'bt ' + str(self.val) + ' ' + str(self.label)

# Basic block definition

class TACBasicBlock(object):
	def __init__(self, insts):
		self.insts = insts
		self.label = self.insts[0].label

		self.children = []
		self.parents = []

		self.live_in = set()
		self.live_out = set()

		self.child_labels = [inst.label for inst in self.insts 
							if isinstance(inst, TACJmp) or
							   isinstance(inst, TACBt)]

	def __str__(self):
		s = 'Label : ' + str(self.label) + '\n'
		s += 'Parents : ' + str([parent.label for parent in self.parents]) + '\n'
		s += 'Children : ' + str([child.label for child in self.children]) + '\n'

		for idx, item in enumerate(self.insts):
			s += str(idx) + '. ' + str(item) + '\n'

		s += 'Live_in : ' + str([live_var for live_var in self.live_in]) + '\n'
		s += 'Live_out : ' + str([live_var for live_var in self.live_out]) + '\n'

		return s