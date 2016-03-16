require './ast'
require './ast_gen'

def type_check(ast)
end

def type_error(line_number, message)
	puts "ERROR: #{line_number}: Type-Check: #{message}"
	exit
end

# If a class name appears more than once, we fail
def check_duplicates(class_map)
	seen = {}
	classes = class_map.classes
	classes.each do |ast_class|
		if seen.has_key?(ast_class.name)
			line_number = ast_class.name_line
			message = "class #{ast_class.name} redefined"
			type_error(line_number, message)
		else
			seen[ast_class.name] = 1 
		end
	end
end

# Determines if there's a cycle by traversing tree from root "Object" node
def check_cycle(class_map, inheritance_graph)
	visited = []
	check_cycle_visit("Object", inheritance_graph, visited)

	# Get list of class names
	classes = []
	class_map.all_classes.each do |ast_class|
		classes << ast_class.name
	end

	# If contents are not the same, we couldn't reach something from Object, so there's a cycle
	if classes.sort != visited.sort
		puts "Inheritance cycle."
		exit
	end
end

# Traverses subtree
def check_cycle_visit(node, inheritance_graph, visited)
	visited << node
	if inheritance_graph[node]
		inheritance_graph[node].each do |child|
			if not visited.include? child.name
				check_cycle_visit(child.name, inheritance_graph, visited)
			end
		end
	end
end

# Pushes features and attributes down the inheritance tree
def flatten_features(node, class_lut, inheritance_graph, parent_attributes, parent_methods)
	attributes = parent_attributes
	methods = parent_methods

	# Add methods/attributes of this node to parents
	class_lut[node].features.each do | feature |
		if feature.kind == "method" or feature.kind == "method_formals"
			methods << feature
		else
			attributes << feature
		end
	end

	# Assign to object
	class_lut[node].methods = methods
	class_lut[node].attributes = attributes

	# Recurse on a duplicate list
	if inheritance_graph.has_key? node
		inheritance_graph[node].each do | child |
			flatten_features(child.name, class_lut, inheritance_graph, attributes.dup(), methods.dup())
		end
	end
end

def get_class_lut(class_map)
	class_lut = {}
	class_map.all_classes.each do |ast_class|
		class_lut[ast_class.name] = ast_class
	end
	return class_lut
end

# Graph mapping parents to children
def get_inheritance_graph(class_map)
	inheritance_graph = {}

	class_map.all_classes.each do |ast_class|
		# If there's a superclass, add this object to its list, otherwise add it to Object's list
		if ast_class.superclass != nil
			if inheritance_graph.has_key?(ast_class.superclass)
				inheritance_graph[ast_class.superclass] << ast_class
			else
				inheritance_graph[ast_class.superclass] = [ast_class]
			end
		else
			if ast_class.name != "Object"
				if inheritance_graph.has_key?("Object")
					inheritance_graph["Object"] << ast_class
				else
					inheritance_graph["Object"] = [ast_class]
				end
			end
		end
	end
	return inheritance_graph
end

def write_output(filename, out)
	output = File.open("#{filename}-type", "w")
	output << out.to_s()
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

def print_graph(graph)
	graph.each do |k, v|
		puts k + ": "
		v.each do | child |
			puts child.name
		end
		puts "\n"
	end
end

def main()
	filename = ARGV[0].to_s()[0..-5]
	raw_ast = read_ast() # read ast from file
	ast = ast(raw_ast) # generate object representation of ast
	
	class_map = ClassMap.new(ast.classes)

	# No redefined classes
	check_duplicates(class_map)

	# No inheritance cycles
	inheritance_graph = get_inheritance_graph(class_map)
	check_cycle(class_map, inheritance_graph)

	# Flatten features across the inheritance tree
	class_lut = get_class_lut(class_map)
	flatten_features("Object", class_lut, inheritance_graph, [], [])

	write_output(filename, class_map)
end

if __FILE__ == $PROGRAM_NAME
	main()
end