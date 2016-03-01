from ast import *

# Deserializes the AST
def generate_ast(raw_ast):
	iterator = iter(raw_ast)
	
	# find parent map
	c = ""
	while c != "parent_map":
		c = next(iterator)

	# skip parent map
	num_edges = int(next(iterator))
	for i in range(0, num_edges):
		next(iterator)
		next(iterator)

	return ast(iterator)

# Functions to generate an OO representation of the AST from input
def ast(iterator):
	# classes-list
	num_classes = int(next(iterator))
	classes = []
	for i in range(0, num_classes):
		classes += [ast_class(iterator)]
	return AST(classes)

def ast_class(iterator):
    # name:identifier
    name_line = next(iterator)
    name = next(iterator)

    # inherits \n 
    inherits = next(iterator)

    superclass = None
    superclass_line = None
    if inherits == "inherits":
        # superclass:identifier
        superclass_line = next(iterator)
        superclass = next(iterator)

    # features-list
    num_features = int(next(iterator))
    features = []
    for i in range(0, num_features):
    	features += [ast_feature(iterator)]
    return ASTClass(inherits, name, name_line, superclass, superclass_line, features)
        
def ast_feature(iterator):
	# feature-type \n
	kind = next(iterator)

	# name:identifier
	name_line = next(iterator)
	name = next(iterator)

	formals = []
	expr = None
	if kind == "method":
		# formals-list
		num_formals = int(next(iterator))
		if num_formals > 0: kind = "method_formals"
		for i in range(0, num_formals):
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
	type = next(iterator)
	# kind of expression \n
	kind = next(iterator)

	if kind == 'assign':
		expr = ast_assign(iterator, lineno)
	if kind == 'dynamic_dispatch':
		expr = ast_dynamic_dispatch(iterator, lineno)
	if kind == 'static_dispatch':
		expr = ast_static_dispatch(iterator, lineno)
	if kind == 'self_dispatch':
		expr = ast_self_dispatch(iterator, lineno)
	if kind == 'if':
		expr = ast_if(iterator, lineno)
	if kind == 'while':
		expr = ast_while(iterator, lineno)
	if kind == 'block':
		expr = ast_block(iterator, lineno)
	if kind == 'new':
		expr = ast_new(iterator, lineno)
	if kind == 'isvoid':
		expr = ast_isvoid(iterator, lineno)
	if kind == 'plus':
		expr = ast_plus(iterator, lineno)
	if kind == 'minus':
		expr = ast_minus(iterator, lineno)
	if kind == 'times':
		expr = ast_times(iterator, lineno)
	if kind == 'divide':
		expr = ast_divide(iterator, lineno)
	if kind == 'lt':
		expr = ast_lt(iterator, lineno)
	if kind == 'le':
		expr = ast_le(iterator, lineno)
	if kind == 'eq':
		expr = ast_eq(iterator, lineno)
	if kind == 'not':
		expr = ast_not(iterator, lineno)
	if kind == 'negate':
		expr = ast_negate(iterator, lineno)
	if kind == 'integer':
		expr = ast_integer(iterator, lineno)
	if kind == 'string':
		expr = ast_string(iterator, lineno)
	if kind == 'identifier':
		expr = ast_identifier(iterator, lineno)
	if kind == 'true':
		expr = ast_true(iterator, lineno)
	if kind == 'false':
		expr = ast_false(iterator, lineno)
	if kind == 'let':
		expr = ast_let(iterator, lineno)
	if kind == 'case':
		expr = ast_case(iterator, lineno)

	return expr

def ast_assign(iterator, lineno):
	# var:identifier
	var_line = next(iterator)
	var = next(iterator)

	# rhs:exp
	rhs = ast_expression(iterator)
	return ASTAssign(lineno, var, var_line, rhs)

def ast_dynamic_dispatch(iterator, lineno):
	# e:exp
	expr = ast_expression(iterator)

	# method:identifier
	method_line = next(iterator)
	method = next(iterator)

	# args:exp-list
	num_args = int(next(iterator))
	args = []
	for i in range(0, num_args):
		args += [ast_expression(iterator)]
	return ASTDynamicDispatch(lineno, expr, method, method_line, args)

def ast_static_dispatch(iterator, lineno):
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
	for i in range(0, num_args):
		args += [ast_expression(iterator)]
	return ASTStaticDispatch(lineno, expr, typ, typ_line, method, method_line, args)


def ast_self_dispatch(iterator, lineno):
	# method:identifier
	method_line = next(iterator)
	method = next(iterator)

	# args:exp-list
	num_args = int(next(iterator))
	args = []
	for i in range(0, num_args):
		args += [ast_expression(iterator)]
	return ASTSelfDispatch(lineno, method, method_line, args)

def ast_if(iterator, lineno):
	# predicate:exp
	predicate = ast_expression(iterator)
	# then:exp
	then = ast_expression(iterator)
	# else:exp
	els = ast_expression(iterator)
	return ASTIf(lineno, predicate, then, els)

def ast_while(iterator, lineno):
	# predicate:exp
	predicate = ast_expression(iterator)
	# body:exp
	body = ast_expression(iterator)
	return ASTWhile(lineno, predicate, body)

def ast_block(iterator, lineno):
	# body:exp-list
	num_exprs = int(next(iterator))
	body = []
	for i in range(0, num_exprs):
		body += [ast_expression(iterator)]
	return ASTBlock(lineno, body)

def ast_binding(iterator):
	# kind of binding
	kind = next(iterator)

	# var:identifier
	var_line = next(iterator)
	var = next(iterator)

	# type:identifier
	typ_line = next(iterator)
	typ = next(iterator)

	expr = None

	if kind == "let_binding_init":
		# value:expr
		expr = ast_expression(iterator)
	return ASTBinding(kind, var, var_line, typ, typ_line, expr)

def ast_let(iterator, lineno):
	# bindings-list
	num_bindings = int(next(iterator))	
	bindings = []
	for i in range(0, num_bindings):
		bindings += [ast_binding(iterator)]
	expr = ast_expression(iterator)
	return ASTLet(lineno, bindings, expr)

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

def ast_case(iterator, lineno):
	# expr
	expr = ast_expression(iterator)

	# cases-list
	num_cases = int(next(iterator))
	cases = []
	for i in range(0, num_cases):
		cases += [ast_case_element(iterator)]
	return ASTCase(lineno, expr, cases)

def ast_new(iterator, lineno):
	# class:identifier
	typ_line = next(iterator)
	typ = next(iterator)
	return ASTNew(lineno, typ, typ_line)

def ast_isvoid(iterator, lineno):
	# e:exp
	expr = ast_expression(iterator)
	return ASTIsVoid(lineno, expr)

def ast_plus(iterator, lineno):
	operation = 'plus'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2)

def ast_minus(iterator, lineno):
	operation = 'minus'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2)

def ast_times(iterator, lineno):
	operation = 'times'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2)

def ast_divide(iterator, lineno):
	operation = 'divide'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBinOp(lineno, operation, e1, e2)

def ast_lt(iterator, lineno):
	operation = 'lt'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2)

def ast_le(iterator, lineno):
	operation = 'le'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2)

def ast_eq(iterator, lineno):
	operation = 'eq'
	# x:exp
	e1 = ast_expression(iterator)
	# y:exp
	e2 = ast_expression(iterator)
	return ASTBoolOp(lineno, operation, e1, e2)

def ast_not(iterator, lineno):
	# x:exp
	expr = ast_expression(iterator)
	return ASTNot(lineno, expr)

def ast_negate(iterator, lineno):
	# x:exp
	expr = ast_expression(iterator)
	return ASTNegate(lineno, expr)

def ast_integer(iterator, lineno):
	# the_integer_constant \n
	constant = next(iterator)
	return ASTInteger(lineno, constant)

def ast_string(iterator, lineno):
	# the_string_constant \n
	constant = next(iterator)
	return ASTString(lineno, constant)

def ast_true(iterator, lineno):
	# true \n
	return ASTBoolean(lineno, 'true')

def ast_false(iterator, lineno):
	# false \n
	return ASTBoolean(lineno, 'false')

def ast_identifier(iterator, lineno):
	# variable:identifier 
	name_line = next(iterator)
	name = next(iterator)
	return ASTIdentifier(lineno, name, name_line)