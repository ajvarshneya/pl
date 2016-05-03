import random
whitespace = [' ', '\n', '\t', '\r']
s = ""
length = random.randint(0,16384)
for i in range(length):	
	rand = str(chr(random.randint(0, 255)))
	s += rand
print s
