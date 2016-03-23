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
		message = "inheritance cycle: #{path.reverse}"
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
			if fml1.type != fml2.type
				line_number = fml2.type_line
				message = "class #{ast_class_name} redefines method #{method.name} and changes type of formal #{fml2.name}"
				type_error(line_number, message)
			end
		end

		# Check that the formals have the same return types
		if duplicate.type != method.type
			line_number = method.type_line
			message = "class #{ast_class_name} redefines method #{method.name} and changes return type (from #{duplicate.type} to #{method.type})"
			type_error(line_number, message)
		end
	end
end

# Check that formal has a defined type, note that it CANNOT be SELF_TYPE
def check_formal_type(ast_class_name, method_name, formal, class_lut)
	if not class_lut.include? formal.type
		line_number = formal.type_line
		message = "class #{ast_class_name} has method #{method_name} with formal parameter of unknown type #{formal.type}"
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
	if not (class_lut.include? method.type or method.type == "SELF_TYPE")
		line_number = method.type_line
		message = "class #{ast_class_name} has method #{method.name} with unknown return type #{method.type}"
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
	if not (class_lut.include? attribute.type or attribute.type == "SELF_TYPE")
		line_number = attribute.type_line
		message = "class #{ast_class_name} has attribute #{attribute.name} with unknown type #{attribute.type}"
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

def check_assign(expr)
	if (expr.var == "self")
		line_number = expr.lineno
		message = "cannot assign to self"
		type_error(line_number, message)
	end

	type = get_object_context(expr.var, expr.lineno)
	type1 = check_expression(expr.rhs)
	if not conforms(type1, type)
		line_number = expr.lineno
		message = "#{type1} does not conform to #{type} in assignment"
		type_error(line_number, message)
	end
	expr.static_type = type1
end

def check_dynamic_dispatch(expr)
	type0 = check_expression(expr.expr)

	# Typecheck arguments
	arg_types = []
	for e in  expr.args
		arg_types << check_expression(e)
	end

	type = nil
	if type0 == "SELF_TYPE"
		type = get_class_context()
	else
		type = type0
	end

	# Check that length of formal and actual parameters are equal
	method = get_method_context(type, expr.method, expr.method_line)
	if arg_types.length() != method.formals.length()
		line_number = expr.lineno
		message = "wrong number of actual arguments (#{arg_types.length()} vs. #{method.formals.length()})"
		type_error(line_number, message)
	end

	# Check that formal and actual parameters have the same types
	arg_num = 0
	for arg_type, fml in arg_types.zip(method.formals)
		arg_num += 1
		if not conforms(arg_type, fml.type)
			line_number = expr.lineno
			message = "argument \##{arg_num} type #{arg_type} does not conform to formal type #{fml.type}"
			type_error(line_number, message)
		end
	end

	# Set static type to be return type of method
	if method.type == "SELF_TYPE"
		expr.static_type = type0
	else
		expr.static_type = method.type
	end
end

def check_static_dispatch(expr)
	type0 = check_expression(expr.expr)

	# Check types of formals
	arg_types = []
	for e in  expr.args
		arg_types << check_expression(e)
	end

	# Check that expression type conforms to static type
	if not conforms(type0, expr.type)
		line_number = expr.lineno
		message = "#{type0} does not conform to #{expr.type} in static dispatch"
		type_error(line_number, message)
	end

	# Check that length of formal and actual parameters are equal
	method = get_method_context(expr.type, expr.method, expr.method_line)
	if arg_types.length() != method.formals.length()
		line_number = expr.lineno
		message = "wrong number of actual arguments (#{arg_types.length()} vs. #{method.formals.length()})"
		type_error(line_number, message)
	end

	# Check that formal and actual parameters have the same types
	arg_num = 0
	for arg_type, fml in arg_types.zip(method.formals)
		arg_num += 1
		if not conforms(arg_type, fml.type)
			line_number = expr.lineno
			message = "argument \##{arg_num} type #{arg_type} does not conform to formal type #{fml.type}"
			type_error(line_number, message)
		end
	end

	# Set static type to be return type of method
	if method.type == "SELF_TYPE"
		expr.static_type = type0
	else
		expr.static_type = method.type
	end
end

def check_self_dispatch(expr)
	arg_types = []
	for e in expr.args
		arg_types << check_expression(e)
	end

	type = get_class_context()

	# Check that length of formal and actual parameters are equal
	method = get_method_context(type, expr.method, expr.method_line)
	if arg_types.length() != method.formals.length()
		line_number = expr.lineno
		message = "wrong number of actual arguments (#{arg_types.length()} vs. #{method.formals.length()})"
		type_error(line_number, message)
	end

	# Check that formal and actual parameters have the same types
	arg_num = 0
	for arg_type, fml in arg_types.zip(method.formals)
		arg_num += 1
		if not conforms(arg_type, fml.type)
			line_number = expr.lineno
			message = "argument \##{arg_num} type #{arg_type} does not conform to formal type #{fml.type}"
			type_error(line_number, message)
		end
	end

	expr.static_type = method.type
end

def check_if(expr)
	type1 = check_expression(expr.predicate)
	if type1 != "Bool"
		line_number = expr.lineno
		message = "conditional has type #{type1} instead of Bool"
		type_error(line_number, message)
	end
	type2 = check_expression(expr.thn)
	type3 = check_expression(expr.els)
	expr.static_type = lub(type2, type3)
end

def check_while(expr)
	type1 = check_expression(expr.predicate)
	if type1 != "Bool"
		line_number = expr.lineno
		message = "predicate has type #{type1} instead of Bool"
		type_error(line_number, message)
	end
	type2 = check_expression(expr.body)
	expr.static_type = "Object"
end

def check_block(expr)
	type = nil
	for e in expr.body
		type = check_expression(e)
	end

	expr.static_type = type
end

def check_let(expr)
	# New scope for let bindings
	new_scope()
	for binding in expr.bindings
		# Check if binding variable is self
		if binding.var == "self"
			line_number = binding.var_line
			message = "binding self in a let is not allowed"
			type_error(line_number, message)	
		end

		# Check if binding type is defined
		if not $p_map.has_key? binding.type and 
			binding.type != "Object" and
			binding.type != "SELF_TYPE"

			line_number = binding.type_line
			message = "unknown type #{binding.type}"
			type_error(line_number, message)
		end

		if binding.kind == "let_binding_init"
			# typecheck assigned expression
			type0 = binding.type
			type1 = check_expression(binding.expr)
			if not conforms(type1, type0)
				line_number = expr.lineno
				message = "initializer type #{type1} does not conform to type #{type0}"
				type_error(line_number, message)
			end

			# extend context
			extend_object_context(binding.var, binding.type)
		else
			extend_object_context(binding.var, binding.type)
		end
	end

	# typecheck let expression
	type = check_expression(expr.expr)
	expr.static_type = type

	end_scope()
end

def check_case(expr)
	type0 = check_expression(expr.expr)

	formal_case_types = []
	actual_case_types = []
	for ast_case in expr.cases
		new_scope()
		# Check if self is case variable
		if ast_case.var == "self"
			line_number = ast_case.var_line
			message = "binding self in a case expression is not allowed"
			type_error(line_number, message)	
		end

		# Check if case type is SELF_TYPE
		if ast_case.type == "SELF_TYPE"
			line_number = ast_case.type_line
			message = "using SELF_TYPE as a case branch type is not allowed"
			type_error(line_number, message)	
		end

		# Check if case type is defined
		if not $p_map.has_key? ast_case.type and ast_case.type != "Object"
			line_number = ast_case.var_line
			message = "unknown type #{ast_case.type}"
			type_error(line_number, message)
		end

		extend_object_context(ast_case.var, ast_case.type)

		# Check types are unique
		if formal_case_types.include? ast_case.type
			line_number = ast_case.var_line
			message = "case branch type #{ast_case.type} is bound twice"
			type_error(line_number, message)
		end
		formal_case_types << ast_case.type
		actual_case_types << check_expression(ast_case.body)

		end_scope()
	end

	type = actual_case_types[0]
	for case_type in actual_case_types
		type = lub(type, case_type)
	end

	expr.static_type = type
end

def check_new(expr)
	if not $p_map.has_key? expr.type and 
		expr.type != "SELF_TYPE" and 
		expr.type != "Object"

		line_number = expr.type_line
		message = "unknown type #{expr.type}"
		type_error(line_number, message)
	end
	expr.static_type = expr.type
end

def check_is_void(expr)
	check_expression(expr.expr)
	expr.static_type = "Bool"
end

def check_bin_op(expr)
	type1 = check_expression(expr.e1)
	type2 = check_expression(expr.e2)
	if type1 != "Int" or type2 != "Int"
		line_number = expr.lineno
		message = "arithmetic on #{type1} #{type2} instead of Ints"
		type_error(line_number, message)
	end
	expr.static_type = "Int"
end

def check_bool_op(expr)
	type1 = check_expression(expr.e1)
	type2 = check_expression(expr.e2)

	if type1 == "Bool" or
		type1 == "Int" or
		type1 == "String" or
		type2 == "Bool" or
		type2 == "Int" or
		type2 == "String"
		if type1 != type2
			line_number = expr.lineno
			message = "comparison between #{type1} and #{type2}"
			type_error(line_number, message)
		end
	end
	expr.static_type = "Bool"
end

def check_not(expr)
	type = check_expression(expr.expr)
	if type != "Bool"
		line_number = expr.lineno
		message = "not applied to type #{type} instead of Bool"
		type_error(line_number, message)
	end
	expr.static_type = "Bool"
end

def check_negate(expr)
	type = check_expression(expr.expr)
	if type != "Int"
		line_number = expr.lineno
		message = "negate applied to type #{type} instead of Int"
		type_error(line_number, message)
	end
	expr.static_type = "Int" 
end

def check_integer(expr)
	expr.static_type = "Int"
end

def check_string(expr)
	expr.static_type = "String"
end

def check_boolean(expr)
	expr.static_type = "Bool"
end

def check_identifier(expr)
	expr.static_type = get_object_context(expr.name, expr.lineno)
end

def check_expression(expr)
	if expr.instance_of?(ASTAssign)
		check_assign(expr)
	elsif expr.instance_of?(ASTDynamicDispatch)
		check_dynamic_dispatch(expr)
	elsif expr.instance_of?(ASTStaticDispatch)
		check_static_dispatch(expr)
	elsif expr.instance_of?(ASTSelfDispatch)
		check_self_dispatch(expr)
	elsif expr.instance_of?(ASTIf)
		check_if(expr)
	elsif expr.instance_of?(ASTWhile)
		check_while(expr)
	elsif expr.instance_of?(ASTBlock)
		check_block(expr)
	elsif expr.instance_of?(ASTLet)
		check_let(expr)
	elsif expr.instance_of?(ASTCase)
		check_case(expr)
	elsif expr.instance_of?(ASTNew)
		check_new(expr)
	elsif expr.instance_of?(ASTIsVoid)
		check_is_void(expr)
	elsif expr.instance_of?(ASTBinOp)
		check_bin_op(expr)
	elsif expr.instance_of?(ASTBoolOp)
		check_bool_op(expr)
	elsif expr.instance_of?(ASTNot)
		check_not(expr)
	elsif expr.instance_of?(ASTNegate)
		check_negate(expr)
	elsif expr.instance_of?(ASTInteger)
		check_integer(expr)
	elsif expr.instance_of?(ASTString)
		check_string(expr)
	elsif expr.instance_of?(ASTBoolean)
		check_boolean(expr)
	elsif expr.instance_of?(ASTIdentifier)
		check_identifier(expr)
	end

	return expr.static_type
end

def check_expressions(class_map)
	for ast_class in class_map.classes
		set_class_context(ast_class.name)
		
		# New scope for attributes
		new_scope()

		# Add attributes to object environment
		for attribute in ast_class.parent_attributes + ast_class.attributes
			extend_object_context(attribute.name, attribute.type)
		end

		extend_object_context("self", "SELF_TYPE")

		# Typecheck attribute expressions in this class
		for attribute in ast_class.parent_attributes + ast_class.attributes
			if attribute.kind == "attribute_init"
				body_type = check_expression(attribute.expr)
				if not conforms(body_type, attribute.type)
					line_number = attribute.name_line
					message = "#{body_type} does not conform to #{attribute.type} in initialized attribute"
					type_error(line_number, message)
				end
			end
		end

		# Typecheck method expressions in this class
		for method in ast_class.parent_methods + ast_class.methods
			# New scope for method
			new_scope()

			extend_object_context("self", "SELF_TYPE")

			# Add formal parameters to scope
			for formal in method.formals
				extend_object_context(formal.name, formal.type)
			end

			# Typecheck expression body
			body_type = check_expression(method.expr)

			if body_type != nil
				if not conforms(body_type, method.type)
					line_number = method.name_line
					message = "#{body_type} does not conform to #{method.type} in method #{method.name}"
					type_error(line_number, message)
				end
			end

			end_scope()
		end

		end_scope()
	end
end

def lub(type1, type2)
	if type1 == "SELF_TYPE" and type2 == "SELF_TYPE"
		return "SELF_TYPE"
	end

	if type1 == "SELF_TYPE" and type2 != "SELF_TYPE"
		return lub(get_class_context(), type2)
	end

	if type1 != "SELF_TYPE" and type2 == "SELF_TYPE"
		return lub(type1, get_class_context)
	end

	if type1 != "SELF_TYPE" and type2 != "SELF_TYPE"
		# (T, T')
		# Get path to root from type1
		path = []
		while true
			path << type1
			if type1 == "Object"
				break
			else
				type1 = $p_map[type1]
			end
		end

		# Return the first type that is in the path
		while true
			if path.include? type2
				return type2
			else
				type2 = $p_map[type2]
			end
		end
	end
end

# Returns true if type1 conforms to type2 (i.e. type1 <= type2), otherwise returns false
def conforms(type1, type2)
	if type1 == "SELF_TYPE" and type2 == "SELF_TYPE"
		return true
	end

	if type1 == "SELF_TYPE" and type2 != "SELF_TYPE"
		return conforms(get_class_context(), type2)
	end

	if type1 != "SELF_TYPE" and type2 == "SELF_TYPE"
		return false
	end

	if type1 != "SELF_TYPE" and type2 != "SELF_TYPE"
		# (T, T')
		while true
			if type1 == type2
				return true
			end

			if (type1 == "Object")
				break
			else
				type1 = $p_map[type1]
			end
		end

		return false
	end
end

def set_class_context(identifier)
	$class_context = identifier
end

def get_class_context()
	return $class_context
end

def get_method_context(ast_class_name, method_name, lineno)
	if ast_class_name == "SELF_TYPE"
		methods = $i_map[get_class_context()]
	else
		methods = $i_map[ast_class_name]
	end

	selection = methods.select{|x| x.name == method_name}

	# Throw error if it doesn't exist
	if selection.length() < 1
		line_number = lineno
		message = "unknown method #{method_name} in dispatch on #{ast_class_name}"
		type_error(line_number, message)		
	end
	method = selection[0]
	return method
end

def extend_object_context(identifier, type)
	symbol_table = $symbol_tables.last()
	symbol_table[identifier] = type
end

def get_object_context(identifier, lineno)
	for symbol_table in $symbol_tables.reverse()
		if symbol_table.include? identifier
			return symbol_table[identifier]
		end
	end

	line_number = lineno
	message = "unbound identifier #{identifier}"
	type_error(line_number, message)		

end

def new_scope()
	$symbol_tables += [{}]
end

def end_scope()
	$symbol_tables.pop()
end

def init_type_env(class_map, implementation_map, parent_map, inheritance_graph)
	$symbol_tables = []
	$i_map = implementation_map.map
	$p_map = parent_map.map
	$i_graph = inheritance_graph
	$class_context = nil
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

	init_type_env(class_map, implementation_map, parent_map, inheritance_graph)

	# Typecheck expressions
	check_expressions(class_map)

	output = File.open("#{filename}-type", "w")
	output << class_map.to_s()
	output << implementation_map.to_s()
	output << parent_map.to_s()
	output << ast.to_s()
	output.close()
end

if __FILE__ == $PROGRAM_NAME
	main()
end