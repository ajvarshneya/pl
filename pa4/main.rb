require './ast'
require './ast_gen'

def type_check(ast)
end

def type_error(line_number, message)
	puts "ERROR: #{line_number}: Type-Check: #{message}"
	exit
end

# If a class name appears more than once, we fail
def check_class_redefined(class_map)
	seen = {}
	classes = class_map.all_classes.sort_by{|obj| obj.name_line.to_i}
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
	cycle = classes.sort - visited.sort
	if cycle != []
		line_number = 0
		path = ""
		cycle.each do |class_name|
			path += class_name + " "
		end
		message = "inheritance cycle: #{path}"
		type_error(line_number, message)		
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

def check_class_name(class_map)
	# Find Main definition
	has_main = false
	class_map.classes.each do |ast_class|
		if ast_class.name == "Main"
			has_main = true
		end
	end	

	if not has_main
		line_number = 0
		message = "class Main not found"
		type_error(line_number, message)
	end

	# No SELF_TYPE definition
	class_map.classes.each do |ast_class|
		if ast_class.name == "SELF_TYPE"
			line_number = ast_class.name_line
			message = "class named SELF_TYPE"
			type_error(line_number, message)
		end
	end
end

def check_class_inherits(class_map, class_lut)
	# Check that the superclass isnt a constant
	class_map.classes.each do |ast_class|
		if ast_class.superclass == "Int" ||
			ast_class.superclass == "String" ||
			ast_class.superclass == "Bool"
			line_number = ast_class.superclass_line
			message = "class #{ast_class.name} inherits from #{ast_class.superclass}"
			type_error(line_number, message)
		end
	end

	# Check that each super class has a valid type
	class_map.classes.each do |ast_class|
		if ast_class.superclass != nil
			if not class_lut.include? ast_class.superclass
				line_number = ast_class.superclass_line
				message = "class #{ast_class.name} inherits from unknown class #{ast_class.superclass}"
				type_error(line_number, message)			
			end
		end
	end
end

# Checks if the attribute has been defined more than once
def check_attribute_redefined(ast_class, attributes, attribute)
	attributes.each do | attribute |
		duplicates = attributes.select{|att| att.name == attribute.name}
		if duplicates.length > 1
			duplicate = duplicates[1]
			line_number = duplicate.name_line
			message = "class #{ast_class} redefines attribute #{duplicate.name}"
			type_error(line_number, message)	
		end
	end
end

# Attribute must not be named 'self'
def check_attribute_self(ast_class, attribute)
	if attribute.name == "self"
		line_number = attribute.name_line
		message = "class #{ast_class} has an attribute named self"
		type_error(line_number, message)		
	end
end

# Attribute must have a defined type
def check_attribute_type(ast_class, attribute, class_lut)
	if not class_lut.include? attribute.typ
		line_number = attribute.typ_line
		message = "class #{ast_class} has attribute #{attribute.name} with unknown type #{attribute.typ}"
		type_error(line_number, message)			
	end
end

# Check that main method is defined
def check_method_main(class_map)
	has_main = false
	has_main_no_params = false
	class_map.classes.each do |ast_class|
		if ast_class.name == "Main"
			ast_class.features.each do |feature|
				if feature.name == "main"
					has_main = true
					if feature.formals == []
						has_main_no_params = true
					end
				end
			end
		end
	end
	if not has_main_no_params and not has_main
		line_number = 0
		message = "class Main method main not found"
		type_error(line_number, message)
	elsif not has_main_no_params
		line_number = 0
		message = "class Main method main with 0 parameters not found"
		type_error(line_number, message)
	end
end

def check_method_params(class_map, class_lut)
	class_map.classes.each do |ast_class|
		features = ast_class.features.sort_by{|obj| obj.name_line.to_i}
		features.each do | feature |
			if feature.kind == "method_formals"
				feature.formals.each do |formal|

					# Check that no parameter is named self
					if formal.name == "self"
						line_number = formal.name_line
						message = "class #{ast_class.name} has method #{feature.name} with formal parameter named self"
						type_error(line_number, message)	
					end

					# Check for duplicate parameters
					duplicates = feature.formals.select{|fml| fml.name == formal.name}
					if duplicates.length > 1
						# Select the second instance of the formal
						duplicate = duplicates[1]
						line_number = duplicate.name_line
						message = "class #{ast_class.name} has method #{feature.name} with duplicate formal parameter named #{duplicate.name}"
						type_error(line_number, message)	
					end

					# Check that the formal's type is valid
					if not class_lut.include? formal.typ
						line_number = formal.typ_line
						message = "class #{ast_class.name} has method #{feature.name} with formal parameter of unknown type #{formal.typ}"
						type_error(line_number, message)			
					end
				end
			end
		end
	end
end

def check_method_redefined(class_map)
	# Check that methods are uniquely defined
	class_map.classes.each do |ast_class|
		features = ast_class.features.sort_by{|obj| obj.name_line.to_i}
		features.each do | feature | 
			if feature.kind == "method" or feature.kind == "method_formals"
				# Get list of features with same name
				duplicates = features.select{|method| method.name == feature.name}
				if duplicates.length > 1
					# Select the second instance of the feature
					duplicate = duplicates[1]
					line_number = duplicate.name_line
					message = "class #{ast_class.name} redefines method #{duplicate.name}"
					type_error(line_number, message)	
				end
			end
		end
	end
end

# Pushes features and attributes down the inheritance tree
def flatten_features(ast_class, class_lut, inheritance_graph, parent_attributes, parent_methods, method_table)
	attributes = parent_attributes
	methods = parent_methods

	# Add methods/attributes of this ast_class to parents
	class_lut[ast_class].features.each do | feature |
		if feature.kind == "method" or feature.kind == "method_formals"
			method_table[feature.name] = ast_class
			methods << feature
		else
			attributes << feature
		end
	end

	# Assign to object
	class_lut[ast_class].methods = methods
	class_lut[ast_class].attributes = attributes

	# Typecheck attributes
	attributes.each do | attribute |
		check_attribute_redefined(ast_class, attributes, attribute)
		check_attribute_self(ast_class, attribute)
		check_attribute_type(ast_class, attribute, class_lut)
	end

	# Recurse on a duplicate list
	if inheritance_graph.has_key? ast_class
		inheritance_graph[ast_class].each do | child |
			flatten_features(child.name, class_lut, inheritance_graph, attributes.dup(), methods.dup(), method_table)
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

	class_lut = get_class_lut(class_map)
	inheritance_graph = get_inheritance_graph(class_map)
	
	# No SELF_TYPE definition
	check_class_name(class_map)

	# Check there is a main method
	check_method_main(class_map)

	check_method_params(class_map, class_lut)

	# No redefined classes
	check_class_redefined(class_map)

	# No redefined methods
	check_method_redefined(class_map)

	# Flatten features across the inheritance tree
	flatten_features("Object", class_lut, inheritance_graph, [], [], {})

	# No inheriting undefined or constant types
	check_class_inherits(class_map, class_lut)

	# No inheritance cycles
	check_cycle(class_map, inheritance_graph)

	puts class_map.to_s()
	# write_output(filename, class_map)
end

if __FILE__ == $PROGRAM_NAME
	main()
end