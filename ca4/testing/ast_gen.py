from ast import *

# Deserializes the class map
def class_map_gen(iterator):
	# class_map \n
	c = next(iterator)
	# num classes \n
	num_classes = int(next(iterator))

	class_map = {} # key=class_name, val=attributes_list
	for i in range(num_classes):
		# class name \n
		class_name = next(iterator)
		# num attributes \n
		num_attributes = int(next(iterator))

		# Construct list of attributes
		attributes = []
		for i in range(num_attributes):
			kind = next(iterator) # init or no init
			attribute_name = next(iterator)
			attribute_type = next(iterator)
			if kind == "no_initializer":
				attribute = ASTFeature("attribute_no_init", attribute_name, "0", [], attribute_type, "0", "")
			if kind == "initializer":
				attribute_expr = ast_expression(iterator)
				attribute = ASTFeature("attribute_init", attribute_name, "0", [], attribute_type, "0", attribute_expr)
			attributes += [attribute]

		class_map[class_name] = attributes

	class_map["Int"] = [ASTFeature("attribute_no_init", "x", "0", [], "Int", "0", "0")]
	class_map["Bool"] = [ASTFeature("attribute_no_init", "x", "0", [], "Int", "0", "0")]
	class_map["String"] = [ASTFeature("attribute_no_init", "s", "0", [], "String", "0", "")]

	return class_map

def implementation_map_gen(iterator):
	c = next(iterator) # skip implementation_map label
	num_classes = int(next(iterator)) # number of classes

	implementation_map = {}
	for i in range(num_classes):
		class_name = next(iterator) # name of class
		num_methods = int(next(iterator)) # number of methods

		# Construct list of methods
		methods = [] 
		for i in range(num_methods):
			method_name = next(iterator)
			num_formals = int(next(iterator))

			if num_formals > 0: 
				kind = "method_formals"
			else:
				kind = "method"

			formals = []
			for i in range(num_formals):
				formal_name = next(iterator)
				formal = ASTFormal(formal_name, "0", "", "0")
				formals += [formal]

			associated_class = next(iterator)

			body = ast_expression(iterator)

			method = ASTFeature(kind, method_name, "0", formals, "", "0", body)
			method.associated_class = associated_class

			methods += [method]

		implementation_map[class_name] = methods
	return implementation_map


def parent_map_gen(iterator):
	c = next(iterator) # skip parent_map label
	num_relations = int(next(iterator))

	parent_map = {}
	for i in range(num_relations):
		child_name = next(iterator)
		parent_name = next(iterator)
		parent_map[child_name] = parent_name

	return parent_map

def str_class_map(class_map):
	s = "class_map\n"
	s += str(len(class_map)) + "\n"
	for ast_class_name in sorted(class_map):
		s += ast_class_name + "\n"
		attributes = class_map[ast_class_name]
		s += str(len(attributes)) + "\n"
		for attribute in attributes:
			if attribute.kind == "attribute_no_init":
				s += "no_initializer\n"
				s += attribute.name + "\n"
				s += attribute.typ + "\n"
			if attribute.kind == "attribute_init":
				s += "initializer\n"
				s += attribute.name + "\n"
				s += attribute.typ + "\n"
				s += str(attribute.expr)
	return s

def str_implementation_map(implementation_map):
    # implementation_map \n
	s = "implementation_map\n"
    # number of classes \n
	s += str(len(implementation_map)) + "\n"
	for ast_class_name in sorted(implementation_map):
        # class name \n
		s += ast_class_name + "\n"

		methods = implementation_map[ast_class_name]

		# number of methods \n
		s += str(len(methods)) + "\n"
		for method in methods:
			# name of method \n
			s += method.name + "\n"
            # number of formals \n
			s += str(len(method.formals)) + "\n"
			for formal in method.formals:
                # name of formal \n
				s += formal.name + "\n"
            # class where method was defined \n
			s += method.associated_class + "\n"
            # method body expression
			s += str(method.expr)
	return s

def str_parent_map(parent_map):
	s = "parent_map\n"
	s += str(len(parent_map)) + "\n"
	for child_name in sorted(parent_map):
		s += child_name + "\n"
		s += parent_map[child_name] + "\n"
	return s

# Deserializes the AST
def ast_gen(iterator):
	return ast(iterator)

def ast(iterator):
	# classes-list
	num_classes = int(next(iterator))
	classes = []
	for i in range(num_classes):
		classes += [ast_class(iterator)]
	return AST(classes)

def ast_class(iterator):
    # name:identifier
    name_line = next(iterator)
    name = next(iterator)

    # inherits \n 
    inherits = next(iterator)

    superclass = ""
    superclass_line = ""
    if inherits == "inherits":
        # superclass:identifier
        superclass_line = next(iterator)
        superclass = next(iterator)

    # features-list
    num_features = int(next(iterator))
    features = []
    for i in range(num_features):
    	features += [ast_feature(iterator)]
    return ASTClass(inherits, name, name_line, superclass, superclass_line, features)
        
def ast_feature(iterator):
	# feature-type \n
	kind = next(iterator)

	# name:identifier
	name_line = next(iterator)
	name = next(iterator)

	formals = []
	expr = ""
	if kind == "method":
		# formals-list
		num_formals = int(next(iterator))
		if num_formals > 0: kind = "method_formals"
		for i in range(num_formals):
			formals += [ast_formal(iterator)]

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)

	# body/init:expr
	if kind != "attribute_no_init":
		expr = ast_expression(iterator)
	return ASTFeature(kind, name, name_line, formals, typ, typ_line, expr)

def ast_formal(iterator):
	# name:identifier
	name_line = next(iterator)
	name = next(iterator)

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)
	return ASTFormal(name, name_line, typ, typ_line)

def ast_expression(iterator):
	# lineno \n
	lineno = next(iterator)
	# type expression evalutes to
	static_type = next(iterator)
	# kind of expression \n
	kind = next(iterator)

	if kind == 'assign':
		expr = ast_assign(iterator, lineno, static_type)
	if kind == 'dynamic_dispatch':
		expr = ast_dynamic_dispatch(iterator, lineno, static_type)
	if kind == 'static_dispatch':
		expr = ast_static_dispatch(iterator, lineno, static_type)
	if kind == 'self_dispatch':
		expr = ast_self_dispatch(iterator, lineno, static_type)
	if kind == 'if':
		expr = ast_if(iterator, lineno, static_type)
	if kind == 'while':
		expr = ast_while(iterator, lineno, static_type)
	if kind == 'block':
		expr = ast_block(iterator, lineno, static_type)
	if kind == 'new':
		expr = ast_new(iterator, lineno, static_type)
	if kind == 'isvoid':
		expr = ast_isvoid(iterator, lineno, static_type)
	if kind == 'plus':
		expr = ast_plus(iterator, lineno, static_type)
	if kind == 'minus':
		expr = ast_minus(iterator, lineno, static_type)
	if kind == 'times':
		expr = ast_times(iterator, lineno, static_type)
	if kind == 'divide':
		expr = ast_divide(iterator, lineno, static_type)
	if kind == 'lt':
		expr = ast_lt(iterator, lineno, static_type)
	if kind == 'le':
		expr = ast_le(iterator, lineno, static_type)
	if kind == 'eq':
		expr = ast_eq(iterator, lineno, static_type)
	if kind == 'not':
		expr = ast_not(iterator, lineno, static_type)
	if kind == 'negate':
		expr = ast_negate(iterator, lineno, static_type)
	if kind == 'integer':
		expr = ast_integer(iterator, lineno, static_type)
	if kind == 'string':
		expr = ast_string(iterator, lineno, static_type)
	if kind == 'identifier':
		expr = ast_identifier(iterator, lineno, static_type)
	if kind == 'true':
		expr = ast_true(iterator, lineno, static_type)
	if kind == 'false':
		expr = ast_false(iterator, lineno, static_type)
	if kind == 'let':
		expr = ast_let(iterator, lineno, static_type)
	if kind == 'case':
		expr = ast_case(iterator, lineno, static_type)
	if kind == 'internal':
		expr = ast_internal(iterator, lineno, static_type)

	return expr

def ast_assign(iterator, lineno, static_type):
	# var:identifier
	var_line = next(iterator)
	var = next(iterator)

	# rhs:exp
	rhs = ast_expression(iterator)
	return ASTAssign(lineno, var, var_line, rhs, static_type)

def ast_dynamic_dispatch(iterator, lineno, static_type):
	# e:exp
	expr = ast_expression(iterator)

	# method:identifier
	method_line = next(iterator)
	method = next(iterator)

	# args:exp-list
	num_args = int(next(iterator))
	args = []
	for i in range(num_args):
		args += [ast_expression(iterator)]
	return ASTDynamicDispatch(lineno, expr, method, method_line, args, static_type)

def ast_static_dispatch(iterator, lineno, static_type):
	# e:exp
	expr = ast_expression(iterator)

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)

	# method:identifier
	method_line = next(iterator)
	method = next(iterator)

	# args:exp-list
	num_args = int(next(iterator))
	args = []
	for i in range(num_args):
		args += [ast_expression(iterator)]
	return ASTStaticDispatch(lineno, expr, typ, typ_line, method, method_line, args, static_type)


def ast_self_dispatch(iterator, lineno, static_type):
	# method:identifier
	method_line = next(iterator)
	method = next(iterator)

	# args:exp-list
	num_args = int(next(iterator))
	args = []
	for i in range(num_args):
		args += [ast_expression(iterator)]
	return ASTSelfDispatch(lineno, method, method_line, args, static_type)

def ast_if(iterator, lineno, static_type):
	# predicate:exp
	predicate = ast_expression(iterator)
	# then:exp
	then = ast_expression(iterator)
	# else:exp
	els = ast_expression(iterator)
	return ASTIf(lineno, predicate, then, els, static_type)

def ast_while(iterator, lineno, static_type):
	# predicate:exp
	predicate = ast_expression(iterator)
	# body:exp
	body = ast_expression(iterator)
	return ASTWhile(lineno, predicate, body, static_type)

def ast_block(iterator, lineno, static_type):
	# body:exp-list
	num_exprs = int(next(iterator))
	body = []
	for i in range(num_exprs):
		body += [ast_expression(iterator)]
	return ASTBlock(lineno, body, static_type)

def ast_binding(iterator):
	# kind of binding
	kind = next(iterator)

	# var:identifier
	var_line = next(iterator)
	var = next(iterator)

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)

	expr = ""

	if kind == "let_binding_init":
		# value:expr
		expr = ast_expression(iterator)
	return ASTBinding(kind, var, var_line, typ, typ_line, expr)

def ast_let(iterator, lineno, static_type):
	# bindings-list
	num_bindings = int(next(iterator))	
	bindings = []
	for i in range(num_bindings):
		bindings += [ast_binding(iterator)]
	expr = ast_expression(iterator)
	return ASTLet(lineno, bindings, expr, static_type)

def ast_case_element(iterator):
	# variable:identifier
	var_line = next(iterator)
	var = next(iterator)

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)
	
	# body:exp
	body = ast_expression(iterator)
	return ASTCaseElement(var, var_line, typ, typ_line, body)

def ast_case(iterator, lineno, static_type):
	# expr
	expr = ast_expression(iterator)

	# cases-list
	num_cases = int(next(iterator))
	cases = []
	for i in range(num_cases):
		cases += [ast_case_element(iterator)]
	return ASTCase(lineno, expr, cases, static_type)

def ast_new(iterator, lineno, static_type):
	# class:identifier
	typ_line = next(iterator)
	typ = next(iterator)
	return ASTNew(lineno, typ, typ_line, static_type)

def ast_isvoid(iterator, lineno, static_type):
	# e:exp
	expr = ast_expression(iterator)
	return ASTIsVoid(lineno, expr, static_type)

def ast_plus(iterator, lineno, static_type):
	operation = 'plus'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def ast_minus(iterator, lineno, static_type):
	operation = 'minus'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def ast_times(iterator, lineno, static_type):
	operation = 'times'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def ast_divide(iterator, lineno, static_type):
	operation = 'divide'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2, static_type)

def ast_lt(iterator, lineno, static_type):
	operation = 'lt'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def ast_le(iterator, lineno, static_type):
	operation = 'le'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def ast_eq(iterator, lineno, static_type):
	operation = 'eq'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2, static_type)

def ast_not(iterator, lineno, static_type):
	# x:exp
	expr = ast_expression(iterator)
	return ASTNot(lineno, expr, static_type)

def ast_negate(iterator, lineno, static_type):
	# x:exp
	expr = ast_expression(iterator)
	return ASTNegate(lineno, expr, static_type)

def ast_integer(iterator, lineno, static_type):
	# the_integer_constant \n
	constant = next(iterator)
	return ASTInteger(lineno, constant, static_type)

def ast_string(iterator, lineno, static_type):
	# the_string_constant \n
	constant = next(iterator)
	return ASTString(lineno, constant, static_type)

def ast_true(iterator, lineno, static_type):
	# true \n
	return ASTBoolean(lineno, 'true', static_type)

def ast_false(iterator, lineno, static_type):
	# false \n
	return ASTBoolean(lineno, 'false', static_type)

def ast_identifier(iterator, lineno, static_type):
	# variable:identifier 
	name_line = next(iterator)
	name = next(iterator)
	return ASTIdentifier(lineno, name, name_line, static_type)

def ast_internal(iterator, lineno, static_type):
	class_method = next(iterator)
	return ASTInternal(static_type, class_method)
