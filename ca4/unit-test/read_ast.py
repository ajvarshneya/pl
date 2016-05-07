from ast import *

# Deserializes the class map
def read_class_map(iterator):
	c = next(iterator)										# class_map
	num_classes = int(next(iterator))						# num classes

	# key=class_name, val=attributes_list
	class_map = {} 
	for i in range(num_classes):
		class_name = next(iterator)							# class name
		num_attributes = int(next(iterator))				# num attributes

		# Construct list of attributes
		attributes = []
		for i in range(num_attributes):
			kind = next(iterator) 							# no_initializer or initializer
			attribute_name = next(iterator)
			attribute_type = next(iterator)
			if kind == "no_initializer":
				attribute = ASTFeature("attribute_no_init", attribute_name, "0", [], attribute_type, "0", "")
			if kind == "initializer":
				attribute_expr = read_ast_expression(iterator)
				attribute = ASTFeature("attribute_init", attribute_name, "0", [], attribute_type, "0", attribute_expr)
			attributes.append(attribute)

		class_map[class_name] = attributes

	# Primitive classes have 1 field each (their raw value)
	class_map["Int"] = [ASTFeature("attribute_no_init", "x", "0", [], "raw.Int", "0", "0")]
	class_map["Bool"] = [ASTFeature("attribute_no_init", "x", "0", [], "raw.Int", "0", "0")]
	class_map["String"] = [ASTFeature("attribute_no_init", "s", "0", [], "raw.String", "0", "")]

	return class_map

def read_imp_map(iterator):
	c = next(iterator) 										# implementation_map
	num_classes = int(next(iterator)) 						# num classes

	implementation_map = {}
	for i in range(num_classes):	
		class_name = next(iterator) 						# class name
		num_methods = int(next(iterator)) 					# num methods

		# Construct list of methods
		methods = [] 
		for i in range(num_methods):
			method_name = next(iterator)					# method name
			num_formals = int(next(iterator))				# num formals

			if num_formals > 0: 
				kind = "method_formals"
			else:
				kind = "method"

			formals = []
			for i in range(num_formals):
				formal_name = next(iterator)				# formal name
				formal = ASTFormal(formal_name, "0", "", "0")
				formals.append(formal)

			associated_class = next(iterator)				# class where method was defined

			body = read_ast_expression(iterator)			# method body

			method = ASTFeature(kind, method_name, "0", formals, "", "0", body)
			method.associated_class = associated_class

			methods.append(method)

		implementation_map[class_name] = methods

	return implementation_map


def read_parent_map(iterator):
	c = next(iterator)										# parent_map
	num_relations = int(next(iterator))						# num edges

	parent_map = {}
	for i in range(num_relations):
		child_name = next(iterator)							# child name
		parent_name = next(iterator)						# parent name
		parent_map[child_name] = parent_name

	return parent_map

def str_class_map(class_map):
	primitives = ["Int", "String", "Bool"]
	s = "class_map\n"										# class_map
	s += str(len(class_map)) + "\n"							# num classes
	for ast_class_name in sorted(class_map):
		s += ast_class_name + "\n"							# class name
		if ast_class_name in primitives:					# check for primitives explicitly
			s += "0\n"
		else:
			attributes = class_map[ast_class_name]
			s += str(len(attributes)) + "\n"				# num attributes
			for attribute in attributes:
				if attribute.kind == "attribute_no_init":
					s += "no_initializer\n"					# no_initializer
					s += attribute.name + "\n"				# attribute name
					s += attribute.typ + "\n"				# attribute type
				if attribute.kind == "attribute_init":
					s += "initializer\n"					# initializer
					s += attribute.name + "\n"				# attribute name
					s += attribute.typ + "\n"				# attribute type
					s += str(attribute.expr)				# attribute initializer
	s = s[0:-1]
	return s

def str_imp_map(imp_map):
	s = "implementation_map\n"								# implementation_map
	s += str(len(imp_map)) + "\n"							# number of classes
	for ast_class_name in sorted(imp_map):
		s += ast_class_name + "\n"							# class name

		methods = imp_map[ast_class_name]

		s += str(len(methods)) + "\n"						# num methods
		for method in methods:
			s += method.name + "\n"							# method name
			s += str(len(method.formals)) + "\n"			# num formals
			for formal in method.formals:
				s += formal.name + "\n"						# formal name
			s += method.associated_class + "\n"				# class where method was defined
			s += str(method.expr)							# method body
	s = s[0:-1]
	return s

def str_parent_map(parent_map):
	s = "parent_map\n"										# parent_map
	s += str(len(parent_map)) + "\n"						# num edges
	for child_name in sorted(parent_map):
		s += child_name + "\n"								# child name
		s += parent_map[child_name] + "\n"					# parent name
	s = s[0:-1]
	return s

def read_ast(iterator):
	num_classes = int(next(iterator))						# classes-list
	classes = []
	for i in range(num_classes):
		classes.append(read_ast_class(iterator))
	return AST(classes)

def read_ast_class(iterator):
    name_line = next(iterator)								# name:identifier
    name = next(iterator)

    inherits = next(iterator)								# inherits or no_inherits

    superclass = ""
    superclass_line = ""
    if inherits == "inherits":
        superclass_line = next(iterator)					# superclass:identifier
        superclass = next(iterator)

    num_features = int(next(iterator))						# features-list
    features = []
    for i in range(num_features):
    	features.append(read_ast_feature(iterator))
    return ASTClass(inherits, name, name_line, superclass, superclass_line, features)
        
def read_ast_feature(iterator):
	kind = next(iterator)									# feature-type

	name_line = next(iterator)								# name:identifier
	name = next(iterator)

	formals = []
	expr = ""
	if kind == "method":
		num_formals = int(next(iterator))					# formals-list
		if num_formals > 0: kind = "method_formals"
		for i in range(num_formals):
			formals.append(read_ast_formal(iterator))

	typ_line = next(iterator)								# type:identifier
	typ = next(iterator)

	if kind != "attribute_no_init":
		expr = read_ast_expression(iterator)				# body/init:expr
	return ASTFeature(kind, name, name_line, formals, typ, typ_line, expr)

def read_ast_formal(iterator):
	name_line = next(iterator)								# name:identifier
	name = next(iterator)

	typ_line = next(iterator)								# type:identifier
	typ = next(iterator)
	return ASTFormal(name, name_line, typ, typ_line)

def read_ast_expression(iterator):
	lineno = next(iterator)									# lineno
	static_type = next(iterator)							# static type
	kind = next(iterator)									# kind of expression

	if kind == 'assign':
		expr = read_ast_assign(iterator, lineno, static_type)
	if kind == 'dynamic_dispatch':
		expr = read_ast_dynamic_dispatch(iterator, lineno, static_type)
	if kind == 'static_dispatch':
		expr = read_ast_static_dispatch(iterator, lineno, static_type)
	if kind == 'self_dispatch':
		expr = read_ast_self_dispatch(iterator, lineno, static_type)
	if kind == 'if':
		expr = read_ast_if(iterator, lineno, static_type)
	if kind == 'while':
		expr = read_ast_while(iterator, lineno, static_type)
	if kind == 'block':
		expr = read_ast_block(iterator, lineno, static_type)
	if kind == 'new':
		expr = read_ast_new(iterator, lineno, static_type)
	if kind == 'isvoid':
		expr = read_ast_isvoid(iterator, lineno, static_type)
	if kind == 'plus':
		expr = read_ast_plus(iterator, lineno, static_type)
	if kind == 'minus':
		expr = read_ast_minus(iterator, lineno, static_type)
	if kind == 'times':
		expr = read_ast_times(iterator, lineno, static_type)
	if kind == 'divide':
		expr = read_ast_divide(iterator, lineno, static_type)
	if kind == 'lt':
		expr = read_ast_lt(iterator, lineno, static_type)
	if kind == 'le':
		expr = read_ast_le(iterator, lineno, static_type)
	if kind == 'eq':
		expr = read_ast_eq(iterator, lineno, static_type)
	if kind == 'not':
		expr = read_ast_not(iterator, lineno, static_type)
	if kind == 'negate':
		expr = read_ast_negate(iterator, lineno, static_type)
	if kind == 'integer':
		expr = read_ast_integer(iterator, lineno, static_type)
	if kind == 'string':
		expr = read_ast_string(iterator, lineno, static_type)
	if kind == 'identifier':
		expr = read_ast_identifier(iterator, lineno, static_type)
	if kind == 'true':
		expr = read_ast_true(iterator, lineno, static_type)
	if kind == 'false':
		expr = read_ast_false(iterator, lineno, static_type)
	if kind == 'let':
		expr = read_ast_let(iterator, lineno, static_type)
	if kind == 'case':
		expr = read_ast_case(iterator, lineno, static_type)
	if kind == 'internal':
		expr = read_ast_internal(iterator, lineno, static_type)

	return expr

def read_ast_assign(iterator, lineno, static_type):
	var_line = next(iterator)									# var:identifier
	var = next(iterator)

	rhs = read_ast_expression(iterator)							# rhs:exp
	return ASTAssign(lineno, var, var_line, rhs, static_type)

def read_ast_dynamic_dispatch(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# receiver:exp

	method_line = next(iterator)								# method:identifier
	method = next(iterator)

	num_args = int(next(iterator))								# args:exp-list
	args = []
	for i in range(num_args):
		args.append(read_ast_expression(iterator))
	return ASTDynamicDispatch(lineno, expr, method, method_line, args, static_type)

def read_ast_static_dispatch(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# receiver:exp

	typ_line = next(iterator)									# type:identifier
	typ = next(iterator)

	method_line = next(iterator)								# method:identifier
	method = next(iterator)

	num_args = int(next(iterator))								# args:exp-list
	args = []
	for i in range(num_args):
		args.append(read_ast_expression(iterator))
	return ASTStaticDispatch(lineno, expr, typ, typ_line, method, method_line, args, static_type)

def read_ast_self_dispatch(iterator, lineno, static_type):
	method_line = next(iterator)								# method:identifier
	method = next(iterator)

	num_args = int(next(iterator))								# args:exp-list
	args = []
	for i in range(num_args):
		args.append(read_ast_expression(iterator))
	return ASTSelfDispatch(lineno, method, method_line, args, static_type)

def read_ast_if(iterator, lineno, static_type):
	predicate = read_ast_expression(iterator)					# predicate:exp
	then = read_ast_expression(iterator)						# then:exp
	els = read_ast_expression(iterator)							# else:exp
	return ASTIf(lineno, predicate, then, els, static_type)

def read_ast_while(iterator, lineno, static_type):
	predicate = read_ast_expression(iterator)					# predicate:exp
	body = read_ast_expression(iterator)						# body:exp
	return ASTWhile(lineno, predicate, body, static_type)

def read_ast_block(iterator, lineno, static_type):
	num_exprs = int(next(iterator))								# body:exp-list
	body = []
	for i in range(num_exprs):
		body.append(read_ast_expression(iterator))
	return ASTBlock(lineno, body, static_type)

def read_ast_binding(iterator):
	kind = next(iterator)										# kind of binding

	var_line = next(iterator)									# var:identifier
	var = next(iterator)

	typ_line = next(iterator)									# type:identifier
	typ = next(iterator)

	expr = ""

	if kind == "let_binding_init":
		expr = read_ast_expression(iterator)					# value:expr
	return ASTBinding(kind, var, var_line, typ, typ_line, expr)

def read_ast_let(iterator, lineno, static_type):
	num_bindings = int(next(iterator))							# bindings-list
	bindings = []
	for i in range(num_bindings):
		bindings.append(read_ast_binding(iterator))
	expr = read_ast_expression(iterator)
	return ASTLet(lineno, bindings, expr, static_type)

def read_ast_case_element(iterator):
	var_line = next(iterator)									# var:identifier
	var = next(iterator)

	typ_line = next(iterator)									# type:identifier
	typ = next(iterator)
	
	body = read_ast_expression(iterator)						# body:exp
	return ASTCaseElement(var, var_line, typ, typ_line, body)

def read_ast_case(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# expr

	num_cases = int(next(iterator))								# cases-lists
	cases = []
	for i in range(num_cases):
		cases.append(read_ast_case_element(iterator))
	return ASTCase(lineno, expr, cases, static_type)

def read_ast_new(iterator, lineno, static_type):
	typ_line = next(iterator)									# class:identifier
	typ = next(iterator)
	return ASTNew(lineno, typ, typ_line, static_type)

def read_ast_isvoid(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# e:exp
	return ASTIsVoid(lineno, expr, static_type)

def read_ast_plus(iterator, lineno, static_type):
	operation = 'plus'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def read_ast_minus(iterator, lineno, static_type):
	operation = 'minus'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def read_ast_times(iterator, lineno, static_type):
	operation = 'times'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def read_ast_divide(iterator, lineno, static_type):
	operation = 'divide'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def read_ast_lt(iterator, lineno, static_type):
	operation = 'lt'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def read_ast_le(iterator, lineno, static_type):
	operation = 'le'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def read_ast_eq(iterator, lineno, static_type):
	operation = 'eq'
	e1 = read_ast_expression(iterator)							# x:exp
	e2 = read_ast_expression(iterator)							# y:exp
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def read_ast_not(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# x:exp
	return ASTNot(lineno, expr, static_type)

def read_ast_negate(iterator, lineno, static_type):
	expr = read_ast_expression(iterator)						# x:exp
	return ASTNegate(lineno, expr, static_type)

def read_ast_integer(iterator, lineno, static_type):
	constant = next(iterator)									# the_integer_constant
	return ASTInteger(lineno, constant, static_type)

def read_ast_string(iterator, lineno, static_type):
	constant = next(iterator)									# the_string_constant
	return ASTString(lineno, constant, static_type)

def read_ast_true(iterator, lineno, static_type):
	return ASTBoolean(lineno, 'true', static_type)				# true

def read_ast_false(iterator, lineno, static_type):
	return ASTBoolean(lineno, 'false', static_type)				# false

def read_ast_identifier(iterator, lineno, static_type):
	name_line = next(iterator)									# var:identifier 
	name = next(iterator)
	return ASTIdentifier(lineno, name, name_line, static_type)

def read_ast_internal(iterator, lineno, static_type):
	class_method = next(iterator)								# Class.method
	return ASTInternal(static_type, class_method)
