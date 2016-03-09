# comment
class comment(object):
	def __init__(self, comment):
		self.comment = comment

	def __str__(self):
		s = '\t# ' + str(self.comment)
		return s

# movl
class movl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\tmovl\t" + str(self.src) + ", " + str(self.dst)
		return s

# movq
class movq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\tmovq\t" + str(self.src) + ", " + str(self.dst)
		return s

# addl
class addl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\taddl\t" + str(self.src) + ", " + str(self.dst)
		return s

# addq
class addq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\taddq\t" + str(self.src) + ", " + str(self.dst)
		return s

# subl
class subl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\tmov\t" + str(self.src) + ", " + str(self.dst)
		return s

# subq
class subq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\tsubq\t" + str(self.src) + ", " + str(self.dst)
		return s

# imull
class imull(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\timull\t" + str(self.src) + ", " + str(self.dst)
		return s

# idivl
class idivl(object):
	def __init__(self, src):
		self.src = src

	def __str__(self):
		s = "\tidivl\t" + str(self.src)
		return s

# jl
class jl(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tjl\t" + str(self.label)
		return s

# jle
class jle(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tjle\t" + str(self.label)
		return s

# je
class je(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tje\t" + str(self.label)
		return s

# jnz
class jnz(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tjnz\t" + str(self.label)
		return s

# ret
class ret(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\treturn"
		return s

# call
class call(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tcall\t" + str(self.label)
		return s

# pushq
class pushq(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\tpushq\t" + str(self.register)
		return s

# popq
class popq(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\tpopq\t" + str(self.register)
		return s


# # .directive
# class directive(object):
# 	def __init__(self, label, name):
# 		self.label = label
# 		self.name = name

# 	def __str__(self):
# 		s = "\tmov\t" + str(self.src) + ", " + str(self.dst)
# 		return s

# label
class label(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = str(self.label) + ":"
		return s

# cmpl
class cmpl(object):
	def __init__(self, op1, op2):
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		s = "\tcmpl\t" + str(self.op2) + ", " + str(self.op1)
		return s

# negl
class negl(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\tnegl\t" + str(self.register)
		return s

# xorl
class xorl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\txorl\t" + str(self.src) + ", " + str(self.dst)
		return s

# xchgl
class xchgl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\txchgl\t" + str(self.src) + ", " + str(self.dst)
		return s

# cltd
class cltd(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\tcltd"
		return s

# jmp
class jmp(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\tjmp\t" + str(self.label)
		return s

# leaq
class leaq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\tleaq\t" + str(self.src) + ", " + str(self.dst)
		return s

# leave
class leave(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\tleave"
		return s

# return
class ret(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\tret"
		return s