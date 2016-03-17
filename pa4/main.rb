require './ast'
require './ast_gen'

def type_check(ast)
end

def check_duplicates(ast)
	seen = {}
	classes = ast.classes
	for ast_class in classes
		if seen.has_key?(ast_class.name)
			puts "Redefined classes."
			exit
		else
			seen[ast_class.name] = 1 
		end
	end
end

def get_inheritance_graph(ast)
	inheritance_graph = {}
	classes = ast.classes
	for ast_class in classes
		# If there's a superclass, add this object to its list
		if ast_class.superclass != nil
			if inheritance_graph.has_key?(ast_class.superclass)
				inheritance_graph[ast_class.superclass] << ast_class
			else
				inheritance_graph[ast_class.superclass] = [ast_class]
			end
		# else
		# 	inheritance_tree["Object"] = [ast_class]
		end
		# 
	end
end

def write_annotated_ast(filename, ast)
	output = File.open("#{filename}-type", "w")
	output << AnnotatedAST.new(ast.classes).to_s_cmap()
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
	filename = ARGV[0].to_s()[0..-5]
	raw_ast = read_ast()
	ast = ast(raw_ast)
	check_duplicates(ast)
	inheritance_graph = get_inheritance_graph(ast)
	puts ClassMap.new(ast, inheritance_graph).to_s()
	# puts ast.to_s()
	# puts AnnotatedAST.new(ast.classes).to_s_cmap()
	# write_annotated_ast(filename, ast)
end

if __FILE__ == $PROGRAM_NAME
	main()
end