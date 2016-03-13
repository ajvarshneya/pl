require './ast'
require './ast_gen'

def type_check(ast)
end

def write_annotated_ast(filename, ast)
	output = File.open("#{filename}-type", "w")
	output << AnnotatedAST.new(ast.classes).to_s()
	output.close()
end

def read_ast()
	lines = []
	while true
		line = gets()
		if line == nil
			break
		end
		line = line.gsub(/[\r\n]+\z/, '')
		lines << line
	end
	return lines
end

def main()
	filename = ARGF.argv[0].to_s()[0..-5]
	raw_ast = read_ast()
	ast = ast(raw_ast)
	puts AnnotatedAST.new(ast.classes).to_s()
	# write_annotated_ast(filename, ast)
end

if __FILE__ == $PROGRAM_NAME
	main()
end