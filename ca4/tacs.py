
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
	def __init__(self, op1):
		self.op1 = op1

	def __str__(self):
		return 'return ' + str(self.op1)

class TACBt(object):
	def __init__(self, op1, label):
		self.op1 = op1
		self.label = label

	def __str__(self):
		return 'bt ' + str(self.op1) + ' ' + str(self.label)

class TACStore(object):
	def __init__(self, op1):
		self.op1 = op1

	def __str__(self):
		return 'store ' + str(self.op1)

class TACLoad(object):
	def __init__(self, assignee, val):
		self.assignee = assignee
		self.val = val

	def __str__(self):
		return str(self.assignee) + ' <- load ' + str(self.val)

class TACBox(object):
	def __init__(self, assignee, op1, box_type):
		self.assignee = assignee
		self.op1 = op1
		self.box_type = box_type

	def __str__(self):
		return str(self.assignee) + ' <- box ' + str(self.box_type) + " " + str(self.op1)

class TACUnbox(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- unbox ' + str(self.op1)

class TACLoadParam(object):
	def __init__(self, assignee, op1):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return str(self.assignee) + ' <- load_param ' + str(self.op1)

class TACLoadAttribute(object):
	def __init__(self, assignee, op1, identifier):
		self.assignee = assignee
		self.op1 = op1
		self.identifier = identifier

	def __str__(self):
		return str(self.assignee) + ' <- load_attr ' + str(self.op1) + ', ' + str(self.identifier)

class TACStoreAttribute(object):
	def __init__(self, op1, identifier):
		self.op1 = op1
		self.identifier = identifier

	def __str__(self):
		return str(self.identifier) + ' <- store_attr ' + str(self.op1)

class TACComment(object):
	def __init__(self, text):
		self.text = text

	def __str__(self):
		return "# " + str(self.text)
