# comment
class comment(object):
	def __init__(self, comment):
		self.comment = comment

	def __str__(self):
		s = "\t\t\t# " + str(self.comment) + "\n"
		return s

# movl
class movl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\tmovl " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# movq
class movq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\tmovq " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# addl
class addl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\taddl " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# addq
class addq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\taddq " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# subl
class subl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\tsubl " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# subq
class subq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\tsubq " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# imull
class imull(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\timull " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# idivl
class idivl(object):
	def __init__(self, src):
		self.src = src

	def __str__(self):
		s = "\t\t\tidivl " + str(self.src) + "\n"
		return s

# jl
class jl(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tjl " + str(self.label) + "\n"
		return s

# jle
class jle(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tjle " + str(self.label) + "\n"
		return s

# je
class je(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tje " + str(self.label) + "\n"
		return s

# jnz
class jnz(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tjnz " + str(self.label) + "\n"
		return s

# call
class call(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tcall " + str(self.label) + "\n"
		return s

# pushq
class pushq(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\t\t\tpushq " + str(self.register) + "\n"
		return s

# popq
class popq(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\t\t\tpopq " + str(self.register) + "\n"
		return s


# # .directive
# class directive(object):
# 	def __init__(self, label, name):
# 		self.label = label
# 		self.name = name

# 	def __str__(self):
# 		s = "\t\t\tmov " + str(self.src) + ", " + str(self.dst)
# 		return s

# label
class label(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = str(self.label) + ":" + "\n"
		return s

# cmpl
class cmpl(object):
	def __init__(self, op1, op2):
		self.op1 = op1
		self.op2 = op2

	def __str__(self):
		s = "\t\t\tcmpl " + str(self.op2) + ", " + str(self.op1) + "\n"
		return s

# negl
class negl(object):
	def __init__(self, register):
		self.register = register

	def __str__(self):
		s = "\t\t\tnegl " + str(self.register) + "\n"
		return s

# xorl
class xorl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\txorl " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# xchgl
class xchgl(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\txchgl " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# cltd
class cltd(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\t\t\tcltd" + "\n"
		return s

# jmp
class jmp(object):
	def __init__(self, label):
		self.label = label

	def __str__(self):
		s = "\t\t\tjmp " + str(self.label) + "\n"
		return s

# leaq
class leaq(object):
	def __init__(self, src, dst):
		self.src = src
		self.dst = dst

	def __str__(self):
		s = "\t\t\tleaq " + str(self.src) + ", " + str(self.dst) + "\n"
		return s

# leave
class leave(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\t\t\tleave" + "\n"
		return s

# return
class ret(object):
	def __init__(self):
		pass

	def __str__(self):
		s = "\t\t\tret" + "\n"
		return s