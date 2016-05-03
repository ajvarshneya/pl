import random
whitespace = [' ', '\n', '\t', '\r']
s = ""
length = random.randint(0,100)
for i in range(length):
	
	num = str(random.randint(0, 9))
	rand = str(chr(random.randint(0, 255)))
	space = whitespace[random.randint(0, 3)]

	seed = random.randint(0, 4)
	if (seed < 3): 
		s += num
	elif (seed == 3):
		s += str(space)
	else: 
		s += rand
print s
