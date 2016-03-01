import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

def  main():
	# read input and generate AST object
	filename = sys.argv[1]
	raw_ast = read_input(filename)
	ast = generate_ast(raw_ast)
	# print str(ast)[:-1]

	tac_ast(ast)

	s = "comment start" + "\n" 
	for tac in tacs:
		s += str(tac) + "\n"
	print s[:-1]

if __name__ == '__main__':
	main()