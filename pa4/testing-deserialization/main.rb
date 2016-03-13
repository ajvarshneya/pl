require './ast'
require './ast_gen'

def main()
	filename = ARGV[1]
	raw_ast = read_ast(filename)
	ast = ast(raw_ast)
	puts ast.to_s()
end

if __FILE__ == $PROGRAM_NAME
	main()
end