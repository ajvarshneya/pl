
# Arithmetic instructions
class TACAssign(object):
	def __init__(self, assignee, op1, static_type):
		self.assignee = assignee
		self.op1 = op1

	def __str__(self):
		return 	(str(self.assignee) + ' <- ' + str(self.op1))

# Need static types to statically determine offsets in the virtual method table
class TACDynamicDispatch(object):
	def __init__(self, assignee, receiver, method_name, params, static_type):
		self.assignee = assignee
		self.receiver = receiver
		self.method_name = method_name
		self.params = params
		self.static_type = static_type

	def __str__(self):
		s = str(self.assignee)
		s += ' <- ' + self.receiver + '.' + self.method_name + '('
		s += params[0]
		for p in params[1:-1]:
			s += ', ' + p 
		s += ")"
		return 	s

class TACStaticDispatch(object):
	def __init__(self, assignee, receiver, params, static_type):
		self.assignee = assignee
		self.receiver = receiver
		self.method_name = method_name
		self.params = params
		self.static_type = static_type

	def __str__(self):
		s = self.assignee
		s += ' <- ' + self.receiver + '@' + self.static_type + '.' + self.method_name + '('
		s += self.params[0]
		for p in self.params[1:-1]:
			s += ', ' + p 
		s += ")"
		return 	s

class TACSelfDispatch(object):
	def __init__(self, assignee, method_name, params, static_type):
		self.assignee = assignee
		self.method_name = method_name
		self.params = params
		self.static_type = static_type

	def __str__(self):
		s = self.assignee
		s += ' <- ' + method_name + '('
		s += params[0]
		for p in params[1:-1]:
			s += ', ' + p 
		s += ")"
		return 	s

class TACPlus(object):
	def __init__(self, assignee, op1, op2, static_type):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2
		self.static_type = static_type

	def __str__(self):
		return 	(str(self.assignee) + ' <- + ' + str(self.op1) + ' ' + str(self.op2))

class TACMinus(object):
	def __init__(self, assignee, op1, op2, static_type):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2
		self.static_type = static_type

	def __str__(self):
		return 	str(self.assignee) + ' <- - ' + str(self.op1) + ' ' + str(self.op2)

class TACMultiply(object):
	def __init__(self, assignee, op1, op2, static_type):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2
		self.static_type = static_type

	def __str__(self):
		return 	str(self.assignee) + ' <- * ' + str(self.op1) + ' ' + str(self.op2)

class TACDivide(object):
	def __init__(self, assignee, op1, op2, static_type):
		self.assignee = assignee
		self.op1 = op1
		self.op2 = op2
		self.static_type = static_type

	def __str__(self):
		return 	str(self.assignee) + ' <- / ' + str(self.op1) + ' ' + str(self.op2)

# # Comparison instructions
# class TACLT(object):
# 	def __init__(self, assignee, op1, op2, int_label, bool_label, string_label, other_label, exit_label):
# 		self.assignee = assignee
# 		self.op1 = op1
# 		self.op2 = op2
# 		self.int_label = int_label
# 		self.bool_label = bool_label
# 		self.string_label = string_label
# 		self.other_label = other_label
# 		self.exit_label = exit_label
		
# 	def __str__(self):
# 		return 	str(self.assignee) + ' <- < ' + str(self.op1) + ' ' + str(self.op2)

# class TACLEQ(object):
# 	def __init__(self, assignee, op1, op2, int_label, bool_label, string_label, other_label, exit_label):
# 		self.assignee = assignee
# 		self.op1 = op1
# 		self.op2 = op2
# 		self.int_label = int_label
# 		self.bool_label = bool_label
# 		self.string_label = string_label
# 		self.other_label = other_label
# 		self.exit_label = exit_label

# 	def __str__(self):
# 		return 	str(self.assignee) + ' <- <= ' + str(self.op1) + ' ' + str(self.op2)

# class TACEqual(object):
# 	def __init__(self, assignee, op1, op2, int_label, bool_label, string_label, other_label, exit_label):
# 		self.assignee = assignee
# 		self.op1 = op1
# 		self.op2 = op2
# 		self.int_label = int_label
# 		self.bool_label = bool_label
# 		self.string_label = string_label
# 		self.other_label = other_label
# 		self.exit_label = exit_label

# 	def __str__(self):
# 		return 	str(self.assignee) + ' <- = ' + str(self.op1) + ' ' + str(self.op2)

# class TACGetType(object):
# 	def __init__(self, assignee, op1):
# 		self.assignee = assignee
# 		self.op1 = op1

# 	def __str__(self):
# 		return 	str(self.assignee) + ' <- get_type ' + str(self.op1)

# class TACCmpType(object):
# 	def __init__(self, op1, op2, eq_label, neq_label):
# 		self.op1 = op1
# 		self.op2 = op2
# 		self.eq_label = eq_label
# 		self.neq_label = neq_label

# 	def __str__(self):
# 		return 'cmp_type ' + str(self.op1) + str(self.op2)

# class TACBranchToComparison(object):
# 	def __init__(self, op1, int_label, bool_label, string_label, other_label):
# 		self.op1 = op1
# 		self.int_label = int_label
# 		self.bool_label = bool_label
# 		self.string_label = string_label
# 		self.other_label = other_label

# 	def __str__(self):
# 		return 	"select_comparison " + str(self.op1)

# Constant assignment instructions
class TACInt(object):
	def __init__(self, assignee, val, static_type):
		self.assignee = assignee
		self.val = val
		self.static_type = static_type

	def __str__(self):
		return str(self.assignee) + ' <- int ' + str(self.val)

class TACBool(object):
	def __init__(self, assignee, val, static_type):
		self.assignee = assignee
		self.val = val
		self.static_type = static_type

	def __str__(self):
		return str(self.assignee) + ' <- bool ' + str(self.val)

class TACString(object):
	def __init__(self, assignee, val, static_type):
		self.assignee = assignee
		self.val = val
self.static_type = static_type

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
	def __init__(self, assignee, op1, static_type):
		self.assignee = assignee
		self.op1 = op1
		self.static_type = static_type

	def __str__(self):
		return str(self.assignee) + ' <- load_param ' + str(self.op1)

class TACLoadAttribute(object):
	def __init__(self, assignee, identifier, static_type):
		self.assignee = assignee
		self.identifier = identifier
		self.static_type = static_type

	def __str__(self):
		return str(self.assignee) + ' <- load_attr ' + str(self.identifier)

class TACStoreAttribute(object):
	def __init__(self, identifier, op1, static_type):
		self.identifier = identifier
		self.op1 = op1
		self.static_type = static_type

	def __str__(self):
		return str(self.identifier) + ' <- store_attr ' + str(self.op1)

class TACComment(object):
	def __init__(self, text):
		self.text = text

	def __str__(self):
		return "# " + str(self.text)
