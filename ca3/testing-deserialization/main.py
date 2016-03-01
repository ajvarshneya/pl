import sys
from nodes import *
from tacs import *

symbol_counter = 0
label_counter = 0
symbol_tables = []
tacs = []

def ns():
	global symbol_counter
	c = symbol_counter
	symbol_counter += 1
	return "t$" + str(c)

def nl():
	global label_counter
	c = label_counter
	label_counter += 1
	return str(c)

def get_symbol(identifier):
	global symbol_tables
	for symbol_table in reversed(symbol_tables):
		if identifier in symbol_table:
			return symbol_table[identifier]

	symbol_tables[-1][identifier] = ns()
	return symbol_tables[-1][identifier]

def push_table():
	global symbol_tables
	symbol_tables += [{}]

def pop_table():
	global symbol_tables
	symbol_tables.pop()

def tacs_append(tac):
	global tacs
	tacs += [tac]

def tac_ast(ast):
	for ast_class in ast.classes:
		tac_class(ast_class)

def tac_class(ast_class):
	push_table()
	for feature in ast_class.features:
		tac_feature(ast_class.name, feature)
	pop_table()

# These aren't really used in the reference compiler
def tac_feature(class_name, ast_feature): 
	if ast_feature.kind == "method":
		push_table()
		tacs_append(TACLabel(class_name + "_" + ast_feature.name + "_" + nl()))
		tac_expression(ast_feature.expr)
		pop_table()

	elif ast_feature.kind == "attribute_init":
		pass
	elif ast_feature.kind == "attribute_no_init":
		pass

def tac_formal(ast_formal):
	assignee = get_symbol(ast_formal.name)
	tacs_append(TACDefault(assignee, ast_formal.typ))
	return assignee

def tac_expression(ast_expression):
	if isinstance(ast_expression, ASTAssign):
		return tac_assign(ast_expression)

	elif isinstance(ast_expression, ASTDynamicDispatch): # Not tested
		return tac_dynamic_dispatch(ast_expression)
	elif isinstance(ast_expression, ASTStaticDispatch): # Not tested
		return tac_static_dispatch(ast_expression)

	elif isinstance(ast_expression, ASTSelfDispatch):
		return tac_self_dispatch(ast_expression)
	elif isinstance(ast_expression, ASTIf):
		return tac_if(ast_expression)
	elif isinstance(ast_expression, ASTWhile):
		return tac_while(ast_expression)
	elif isinstance(ast_expression, ASTBlock):
		return tac_block(ast_expression)
	elif isinstance(ast_expression, ASTLet):
		return tac_let(ast_expression)
	elif isinstance(ast_expression, ASTCase):
		return tac_case(ast_expression)
	elif isinstance(ast_expression, ASTNew):
		return tac_new(ast_expression)
	elif isinstance(ast_expression, ASTIsVoid):
		return tac_isvoid(ast_expression)

	elif isinstance(ast_expression, ASTBinOp):
		if ast_expression.operation == "plus":
			return tac_plus(ast_expression)
		if ast_expression.operation == "minus":
			return tac_minus(ast_expression)
		if ast_expression.operation == "times":
			return tac_multiply(ast_expression)
		if ast_expression.operation == "divide":
			return tac_divide(ast_expression)

	elif isinstance(ast_expression, ASTBoolOp):
		if ast_expression.operation == "lt":
			return tac_lt(ast_expression)
		if ast_expression.operation == "le":
			return tac_leq(ast_expression)
		if ast_expression.operation == "eq":
			return tac_eq(ast_expression)

	elif isinstance(ast_expression, ASTNot):
		return tac_not(ast_expression)
	elif isinstance(ast_expression, ASTNegate):
		return tac_negate(ast_expression)
	elif isinstance(ast_expression, ASTInteger):
		return tac_integer(ast_expression)
	elif isinstance(ast_expression, ASTString):
		return tac_string(ast_expression)
	elif isinstance(ast_expression, ASTBoolean):
		return tac_boolean(ast_expression)
	elif isinstance(ast_expression, ASTIdentifier):
		return tac_identifier(ast_expression)

def tac_assign(ast_assign):
	assignee = get_symbol(ast_assign.var)
	expr = tac_expression(ast_assign.rhs)
	tacs_append(TACAssign(assignee, expr))
	return assignee

def tac_dynamic_dispatch(ast_dynamic_dispatch):
	assignee = ns()
	if ast_dynamic_dispatch.method == "in_string":
		tacs_append(TACInString(assignee))
	if ast_dynamic_dispatch.method == "out_string":
		s = tac_string(ast_dynamic_dispatch.args[0])
		tacs_append(TACOutString(assignee, s))
	if ast_dynamic_dispatch.method == "in_int":
		tacs_append(TACInInt(assignee))
	if ast_dynamic_dispatch.method == "out_int":
		i = tac_int(ast_dynamic_dispatch.args[0])
		tacs_append(TACOutInt(assignee, i))
	tacs_append(TACReturn(assignee))

def tac_static_dispatch(ast_static_dispatch):
	assignee = ns()
	if ast_static_dispatch.method == "in_string":
		tacs_append(TACInString(assignee))
	if ast_static_dispatch.method == "out_string":
		s = tac_string(ast_static_dispatch.args[0])
		tacs_append(TACOutString(assignee, s))
	if ast_static_dispatch.method == "in_int":
		tacs_append(TACInInt(assignee))
	if ast_static_dispatch.method == "out_int":
		i = tac_int(ast_static_dispatch.args[0])
		tacs_append(TACOutInt(assignee, i))
	tacs_append(TACReturn(assignee))

def tac_self_dispatch(ast_self_dispatch):
	assignee = ns()
	if ast_self_dispatch.method == "in_string":
		tacs_append(TACInString(assignee))
	if ast_self_dispatch.method == "out_string":
		s = tac_string(ast_self_dispatch.args[0])
		tacs_append(TACOutString(assignee, s))
	if ast_self_dispatch.method == "in_int":
		tacs_append(TACInInt(assignee))
	if ast_self_dispatch.method == "out_int":
		i = tac_int(ast_self_dispatch.args[0])
		tacs_append(TACOutInt(assignee, i))
	tacs_append(TACReturn(assignee))

def tac_if(ast_if):
	then_label = "if_then_" + nl()
	els_label = "if_else_" + nl()
	fi_label = "if_fi_" + nl()

	predicate = tac_expression(ast_if.predicate)
	predicate_not = ns()
	tacs_append(TACNot(predicate_not, predicate))

	# if(predicate)
	tacs_append(TACBt(predicate, then_label))
	tacs_append(TACBt(predicate_not, else_label))

	# then
	tacs_append(TACLabel(then_label))
	then = tac_expression(ast_if.then)
	tacs_append(TACJmp(fi_label))

	# else
	tacs_append(TACLabel(els_label))
	els = tac_expression(ast_if.els)
	tacs_append(TACLabel(fi_label))

def tac_while(ast_while):
	loop_label = "while_loop_" + nl()
	break_label = "while_break_" + nl()

	tacs_append(TACLabel(loop_label))
	predicate = tac_expression(ast_while.predicate)
	predicate_not = ns()
	tacs_append(TACNot(predicate_not, predicate))

	# while(predicate)
	tacs_append(TACBt(predicate_not, break_label))
	body = tac_expression(ast_while.body)
	tacs_append(TACJmp(loop_label))
	tacs_append(TACLabel(break_label))

def tac_block(ast_block):
	for expr in ast_block:
		tac_expression(expr)

def tac_binding(ast_binding):
	if ast_binding.kind == "let_binding_init":
		assignee = get_symbol(ast_binding.var)
		expr = tac_expression(ast_binding.expr)
		tacs_append(TACAssign(assignee, expr))
	if ast_binding.kind == "let_binding_no_init":
		assignee = get_symbol(ast_binding.var)
		typ = ast_binding.typ
		tacs_append(TACDefault(assignee, typ))

def tac_let(ast_let):
	push_table()
	for binding in ast_let.bindings:
		print str(binding)
		tac_binding(binding)
		ast_expression(ast_let.expr)
	pop_table()

def tac_case_element(ast_case):
	pass

def tac_case(ast_case):
	pass

def tac_new(ast_new):
	assignee = ns()
	tacs_append(TACNew(assignee, ast_new.typ))
	return assignee

def tac_isvoid(ast_isvoid):
	assignee = ns()
	expr = tac_expression(ast_isvoid.expr)
	tacs_append(TACIsVoid(assignee, expr))
	return assignee

def tac_plus(ast_plus):
	assignee = ns()
	e1 = tac_expression(ast_plus.e1)
	e2 = tac_expression(ast_plus.e2)
	tacs_append(TACPlus(assignee, e1, e2))
	return assignee	

def tac_minus(ast_minus):
	assignee = ns()
	e1 = tac_expression(ast_minus.e1)
	e2 = tac_expression(ast_minus.e2)
	tacs_append(TACMinus(assignee, e1, e2))
	return assignee

def tac_multiply(ast_times):
	assignee = ns()
	e1 = tac_expression(ast_times.e1)
	e2 = tac_expression(ast_times.e2)
	tacs_append(TACMultiply(assignee, e1, e2))
	return assignee

def tac_divide(ast_divide):
	assignee = ns()
	e1 = tac_expression(ast_divide.e1)
	e2 = tac_expression(ast_divide.e2)
	tacs_append(TACDivide(assignee, e1, e2))
	return assignee

def tac_lt(ast_lt):
	assignee = ns()
	e1 = tac_expression(ast_lt.e1)
	e2 = tac_expression(ast_lt.e2)
	tacs_append(TACLT(assignee, e1, e2))
	return assignee

def tac_le(ast_le):
	assignee = ns()
	e1 = tac_expression(ast_le.e1)
	e2 = tac_expression(ast_le.e2)
	tacs_append(TACLEQ(assignee, e1, e2))
	return assignee

def tac_eq(ast_eq):
	assignee = ns()
	e1 = tac_expression(ast_eq.e1)
	e2 = tac_expression(ast_eq.e2)
	tacs_append(TACEqual(assignee, e1, e2))
	return assignee

def tac_not(ast_not):
	assignee = ns()
	tacs_append(TACInt(assignee, ast_integer.constant))
	return assignee

def tac_negate(ast_negate):
	assignee = ns()
	tacs_append(TACNeg(assignee, ast_negate.constant))
	return assignee

def tac_integer(ast_integer):
	assignee = ns()
	tacs_append(TACInt(assignee, ast_integer.constant))
	return assignee

def tac_string(ast_string):
	assignee = ns()
	tacs_append(TACString(assignee, ast_string.constant))
	return assignee

def tac_boolean(ast_boolean):
	assignee = ns()
	tacs_append(TACBool(assignee, ast_string.constant))
	return assignee

def tac_identifier(ast_identifier):
	assignee = ns()
	tacs_append(TACAssign(assignee, get_symbol(ast_identifier.name)))
	return assignee

##########################################################################################

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

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

def  main():
	# read input and generate AST object
	filename = sys.argv[1]
	raw_ast = read_input(filename)
	ast = generate_ast(raw_ast)
	print str(ast)[:-1]

	# tac_ast(ast)

	# s = "comment start" + "\n" 
	# for tac in tacs:
	# 	s += str(tac) + "\n"
	# print s[:-1]

if __name__ == '__main__':
	main()