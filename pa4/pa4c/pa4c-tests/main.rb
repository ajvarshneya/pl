require './ast'
require './ast_gen'

# Prints error message and exits
def type_error(line_number, message)
	puts "ERROR: #{line_number}: Type-Check: #{message}"
	exit
end

# Determines if there's a cycle by traversing tree from root "Object" node
def check_cycle(class_map, inheritance_graph)
	visited = []
	check_cycle_visit("Object", inheritance_graph, visited)

	# Get list of class names
	classes = []

	for ast_class in class_map.all_classes
		classes << ast_class.name
	end

	# If contents are not the same, we couldn't reach something from Object, so there's a cycle
	cycle = classes.sort - visited.sort
	if cycle != []
		line_number = 0
		path = ""
		for class_name in cycle
			path += class_name + " "
		end
		message = "inheritance cycle: #{path}"
		type_error(line_number, message)		
	end
end

# Traverses subtree to determine if there is a cycle
def check_cycle_visit(node, inheritance_graph, visited)
	visited << node
	if inheritance_graph[node]
		for child in inheritance_graph[node]
			if not visited.include? child.name
				check_cycle_visit(child.name, inheritance_graph, visited)
			end
		end
	end
end

# Checks that no class is defined more than once
def check_class_redefined(class_map)
	seen = {}
	for ast_class in class_map.all_classes.sort_by{|x| x.name_line.to_i}
		if seen.has_key?(ast_class.name)
			line_number = ast_class.name_line
			message = "class #{ast_class.name} redefined"
			type_error(line_number, message)
		else
			seen[ast_class.name] = 1
		end
	end
end


# Checks that there is a Main class
def check_class_main(class_map)
	has_main = false
	for ast_class in class_map.classes
		if ast_class.name == "Main"
			has_main = true
		end
	end	

	if not has_main
		line_number = 0
		message = "class Main not found"
		type_error(line_number, message)
	end
end

# Checks that no class is named SELF_TYPE
def check_class_self(class_map)
	for ast_class in class_map.classes
		if ast_class.name == "SELF_TYPE"
			line_number = ast_class.name_line
			message = "class named SELF_TYPE"
			type_error(line_number, message)
		end
	end
end

# Checks that the class is defined and doesn't inherit from a constant
def check_class_inherits(class_map, class_lut)
	# Check that the superclass isnt a constant
	for ast_class in class_map.classes
		if ast_class.superclass == "Int" ||
			ast_class.superclass == "String" ||
			ast_class.superclass == "Bool"
			line_number = ast_class.superclass_line
			message = "class #{ast_class.name} inherits from #{ast_class.superclass}"
			type_error(line_number, message)
		end
	end

	# Check that each super class has a valid type
	for ast_class in class_map.classes
		if ast_class.superclass != nil
			if not class_lut.include? ast_class.superclass
				line_number = ast_class.superclass_line
				message = "class #{ast_class.name} inherits from unknown class #{ast_class.superclass}"
				type_error(line_number, message)			
			end
		end
	end
end

# Checks that there is a main method
def check_method_main(class_map)
	has_main = false
	has_main_no_params = false
	for ast_class in class_map.classes
		if ast_class.name == "Main"
			for feature in ast_class.methods + ast_class.parent_methods
				if feature.name == "main"
					has_main = true
					if feature.formals == []
						has_main_no_params = true
					end
				end
			end
		end
	end

	if not has_main
		# Doesn't have main
		line_number = 0
		message = "class Main method main not found"
		type_error(line_number, message)
	end

	if not has_main_no_params
		# Has main, but nonzero parameters
		line_number = 0
		message = "class Main method main with 0 parameters not found"
		type_error(line_number, message)
	end
end

# Checks that overridden methods have valid number/types of formals and return types
def check_method_override(ast_class_name, method, parent_methods)
	# Get methods from ancestors with the same name
	duplicates = parent_methods.select{|x| x.name == method.name}
	if duplicates != []
		duplicate = duplicates[0]

		# Check that the number of formals is valid
		if duplicate.formals.length != method.formals.length
			line_number = method.name_line
			message = "class #{ast_class_name} redefines method #{method.name} and changes number of formals"
			type_error(line_number, message)
		end

		# Check that the formals have the same types
		for fml1, fml2 in duplicate.formals.zip(method.formals)
			if fml1.typ != fml2.typ
				line_number = fml2.typ_line
				message = "class #{ast_class_name} redefines method #{method.name} and changes type of formal #{fml2.name}"
				type_error(line_number, message)
			end
		end

		# Check that the formals have the same return types
		if duplicate.typ != method.typ
			line_number = method.typ_line
			message = "class #{ast_class_name} redefines method #{method.name} and changes return type (from #{duplicate.typ} to #{method.typ})"
			type_error(line_number, message)
		end
	end
end

# Check that formal has a defined type, note that it CANNOT be SELF_TYPE
def check_formal_type(ast_class_name, method_name, formal, class_lut)
	if not class_lut.include? formal.typ
		line_number = formal.typ_line
		message = "class #{ast_class_name} has method #{method_name} with formal parameter of unknown type #{formal.typ}"
		type_error(line_number, message)			
	end
end

# Check that formals are uniquely defined in the given list
def check_formal_redefined(ast_class_name, method_name, formals, formal)
	# Get all formals with same name in list
	duplicates = formals.select{|x| x.name == formal.name}
	if duplicates.length > 1
		duplicate = duplicates[1]
		line_number = duplicate.name_line
		message = "class #{ast_class_name} has method #{method_name} with duplicate formal parameter named #{duplicate.name}"
		type_error(line_number, message)	
	end
end

# Check that no formal is named 'self'
def check_formal_self(ast_class_name, method_name, formal)
	if formal.name == "self"
		line_number = formal.name_line
		message = "class #{ast_class_name} has method #{method_name} with formal parameter named self"
		type_error(line_number, message)	
	end
end

# Verifies the types of the given method's formals
def check_method_formals(ast_class_name, method, class_lut)

	formals = method.formals
	method_name = method.name

	# Check that no formal is named 'self' in this method
	for formal in formals
		check_formal_self(ast_class_name, method_name, formal)
	end

	# Check that formals are uniquely defined in this method
	for formal in formals
		check_formal_redefined(ast_class_name, method_name, formals, formal)
	end

	# Check that formals have valid types in this method
	for formal in formals
		check_formal_type(ast_class_name, method_name, formal, class_lut)
	end
end

# Checks that the method has a defined return type
def check_method_return(ast_class_name, method, class_lut)
	if not (class_lut.include? method.typ or method.typ == "SELF_TYPE")
		line_number = method.typ_line
		message = "class #{ast_class_name} has method #{method.name} with unknown return type #{method.typ}"
		type_error(line_number, message)			
	end
end

# Checks that method is uniquely defined in the given list
def check_method_redefined(ast_class_name, methods, method)
	# Get all methods with same name in list
	duplicates = methods.select{|x| x.name == method.name}
	if duplicates.length > 1
		duplicate = duplicates[1]
		line_number = duplicate.name_line
		message = "class #{ast_class_name} redefines method #{duplicate.name}"
		type_error(line_number, message)	
	end
end

# Typechecks class methods by traversing inheritance tree
def check_methods(ast_class_name, class_lut, inheritance_graph)

	ast_class = class_lut[ast_class_name]
	methods = ast_class.methods
	parent_methods = ast_class.parent_methods

	# Check that methods are uniquely defined in this class
	for method in methods
		check_method_redefined(ast_class_name, methods, method)
	end

	# Check that methods have valid return types in this class
	for method in methods
		check_method_return(ast_class_name, method, class_lut)
	end

	# Check that methods have valid parameters in this class
	for method in methods
		if method.kind == "method_formals"
			check_method_formals(ast_class_name, method, class_lut)
		end
	end

	# Check that overridden methods have valid numbers of formals, types of formals, and return types
	for method in methods
		check_method_override(ast_class_name, method, parent_methods)
	end

	# Recurse on children's subtrees
	if inheritance_graph.has_key? ast_class_name
		for child in inheritance_graph[ast_class_name]
			check_methods(child.name, class_lut, inheritance_graph)
		end
	end
end

# Checks that attribute has a defined type
def check_attribute_type(ast_class_name, attribute, class_lut)
	if not (class_lut.include? attribute.typ or attribute.typ == "SELF_TYPE")
		line_number = attribute.typ_line
		message = "class #{ast_class_name} has attribute #{attribute.name} with unknown type #{attribute.typ}"
		type_error(line_number, message)			
	end
end

# Checks that attribute is not named 'self'
def check_attribute_self(ast_class_name, attribute)
	if attribute.name == "self"
		line_number = attribute.name_line
		message = "class #{ast_class_name} has an attribute named self"
		type_error(line_number, message)		
	end
end

# Checks that attribute is uniquely defined in the given list
def check_attribute_ancestors(ast_class_name, attributes, attribute)
	# Get all attributes with same name in the list
	duplicates = attributes.select{|x| x.name == attribute.name}
	if duplicates.length > 0
		duplicate = duplicates[0]
		line_number = attribute.name_line
		message = "class #{ast_class_name} redefines attribute #{duplicate.name}"
		type_error(line_number, message)	
	end
end

# Checks that attribute is uniquely defined in the given list
def check_attribute_redefined(ast_class_name, attributes, attribute)
	# Get all attributes with same name in the list
	duplicates = attributes.select{|x| x.name == attribute.name}
	if duplicates.length > 1
		duplicate = duplicates[1]
		line_number = duplicate.name_line
		message = "class #{ast_class_name} redefines attribute #{duplicate.name}"
		type_error(line_number, message)	
	end
end

# Typechecks class attributes by traversing inheritance tree
def check_attributes(ast_class_name, class_lut, inheritance_graph)

	ast_class = class_lut[ast_class_name]
	attributes = ast_class.attributes
	parent_attributes = ast_class.parent_attributes

	# Check that attributes are uniquely defined in this class
	for attribute in attributes
		check_attribute_redefined(ast_class_name, attributes, attribute)
	end

	# Check that attributes are uniquely defined from ancestors
	for attribute in attributes
		check_attribute_ancestors(ast_class_name, parent_attributes, attribute)
	end

	# Check that no attribute is named 'self' in this class
	for attribute in attributes
		check_attribute_self(ast_class_name, attribute)
	end	

	# Check that attributes have valid types in this class
	for attribute in attributes
		check_attribute_type(ast_class_name, attribute, class_lut)
	end

	# Recurse on children's subtrees
	if inheritance_graph.has_key? ast_class_name
		for child in inheritance_graph[ast_class_name]
			check_attributes(child.name, class_lut, inheritance_graph)
		end
	end
end

# Flattens the attributes/methods of each class with all of its ancestor's attributes/methods
def flatten_parent_features(ast_class_name, class_lut, inheritance_graph, parent_attributes, parent_methods)

	# Update the object with flattened lists
	ast_class = class_lut[ast_class_name]
	ast_class.parent_attributes = parent_attributes
	ast_class.parent_methods = parent_methods

	attributes = ast_class.attributes
	methods = ast_class.methods

	# Set class field of methods (used by implementation map)
	for method in methods
		method.associated_class = ast_class_name
	end

	# Recurse on children
	if inheritance_graph.has_key? ast_class_name
		for child in inheritance_graph[ast_class_name]
			flatten_parent_features(child.name, class_lut, inheritance_graph, (parent_attributes + attributes), (parent_methods + methods))
		end
	end
end

# Returns an adjacency list (hash) representation of the inheritance graph
# with class names mapping to the objects of their children
def get_inheritance_graph(class_map)
	inheritance_graph = {}

	for ast_class in class_map.all_classes

		# If there is a superclass, add the object to its list
		if ast_class.superclass != nil
			if inheritance_graph.has_key?(ast_class.superclass)
				inheritance_graph[ast_class.superclass] << ast_class
			else
				inheritance_graph[ast_class.superclass] = [ast_class]
			end
		else
			# If there is no superclass, add the object to Object's list (root of inheritance tree)
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

# Returns a mapping between class names and their objects
def get_class_lut(class_map)
	class_lut = {}
	for ast_class in class_map.all_classes
		class_lut[ast_class.name] = ast_class
	end
	return class_lut
end

### I/O Functions ###
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

# Used for debuggging
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
	# Generate AST object from file
	filename = ARGV[0].to_s()[0..-5]
	raw_ast = read_ast()
	ast = ast(raw_ast)
	
	# Init class map, look-up table, inheritance graph
	class_map = ClassMap.new(ast.classes)

	class_lut = get_class_lut(class_map)
	inheritance_graph = get_inheritance_graph(class_map)

	# Ensure there are no cycles or duplicates
	check_class_redefined(class_map)
	check_class_inherits(class_map, class_lut)
	check_cycle(class_map, inheritance_graph)

	for ast_class in class_map.all_classes
		puts ast_class.name
		for method in ast_class.methods
			puts method.name
		end
		puts
	end

	# Flatten features across the inheritance tree
	flatten_parent_features("Object", class_lut, inheritance_graph, [], [])

	# Class checks
	check_class_main(class_map)
	check_class_self(class_map)

	# Typecheck attributes
	check_attributes("Object", class_lut, inheritance_graph)	

	# Typecheck methods
	check_methods("Object", class_lut, inheritance_graph)

	# Check that there is a main method
	check_method_main(class_map)

	# Init maps
	implementation_map = ImplementationMap.new(class_map.all_classes)
	parent_map = ParentMap.new(class_map.all_classes)

	write_output(filename, class_map)
	# puts class_map.to_s()
	# puts implementation_map.to_s()
	# puts parent_map.to_s()
	# puts ast.to_s()

	# output = File.open("#{filename}-type", "w")
	# output << class_map.to_s()
	# output << implementation_map.to_s()
	# output << parent_map.to_s()
	# output << ast.to_s()
	# output.close()
end

if __FILE__ == $PROGRAM_NAME
	main()
end