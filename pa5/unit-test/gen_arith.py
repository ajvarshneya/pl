import random
s = ""
for i in range(100000):
	has_parens = random.randint(0,10)
	has_tilde = random.randint(0,10)
	op_sel = random.randint(0,3)
	num = random.randint(0, 2147483647)
	if not has_parens:
		s = "(" + s

	if op_sel == 0:
		s += "+"
	elif op_sel == 1:
		s += "-"
	elif op_sel == 2:
		s += "*"
	elif op_sel == 3:
		s += "/"

	if not has_tilde:
		s += "~"
	s += str(num)

	if not has_parens:
		s = s + ")"
	
	if i % 10 == 0:
		s += "\n"

print s