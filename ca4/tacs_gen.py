from tacs import *
from ast import *

symbol_counter = 0
label_counter = 0
symbol_tables = []

tacs_map = {}
tacs = []

# Returns a new symbol (virtual register)
def ns():
	global symbol_counter
	c = symbol_counter
	symbol_counter += 1
	return "t$" + str(c)

# Returns a new label number
def nl():
	global label_counter
	c = label_counter
	label_counter += 1
	return str(c)

# Returns the symbol if it exists, otherwise a new symbol
def get_symbol(identifier):
	global symbol_tables
	for symbol_table in reversed(symbol_tables):
		if identifier in symbol_table:
			return symbol_table[identifier]

	symbol_tables[-1][identifier] = ns()
	return symbol_tables[-1][identifier]

# Push a new symbol table to stack
def push_table():
	global symbol_tables
	symbol_tables += [{}]

# Pop a symbol table from stack
def pop_table():
	global symbol_tables
	symbol_tables.pop()

# Add tac instruction to global list
def tacs_append(tac):
	global tacs
	tacs += [tac]

# Top level tac generator
def tacs_gen(ast):
	for ast_class in ast.classes:
		tac_class(ast_class)
	return tacs

def tac_class(ast_class):
	push_table()

	for feature in ast_class.features:
		tac_feature(ast_class.name, feature)

	pop_table()

def tac_feature(class_name, ast_feature): 
	if ast_feature.kind == "method":
		push_table()

		assignee = ns()
		tacs_append(TACLabel(class_name + "_" + ast_feature.name + "_" + nl()))
		expr = tac_expression(ast_feature.expr)
		tacs_append(TACReturn(expr))
		
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
			return tac_le(ast_expression)
		if ast_expression.operation == "eq":
			return tac_eq(ast_expression)

	elif isinstance(ast_expression, ASTNot):
		return tac_not(ast_expression)
	elif isinstance(ast_expression, ASTNegate):
		return tac_negate(ast_expression)
	elif isinstance(ast_expression, ASTInteger):
		return tac_int(ast_expression)
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
	return tac_self_dispatch(ast_dynamic_dispatch)

def tac_static_dispatch(ast_static_dispatch):
	return tac_self_dispatch(ast_static_dispatch)

def tac_self_dispatch(ast_self_dispatch):
	assignee = ns()

	if ast_self_dispatch.method == "out_string":
		expr = tac_expression(ast_self_dispatch.args[0])
		tacs_append(TACOutString(assignee, expr))
	if ast_self_dispatch.method == "out_int":
		expr = tac_expression(ast_self_dispatch.args[0])
		tacs_append(TACOutInt(assignee, expr))
	if ast_self_dispatch.method == "in_string":
		tacs_append(TACInString(assignee))
	if ast_self_dispatch.method == "in_int":
		tacs_append(TACInInt(assignee))

	return assignee


def tac_if(ast_if):
	then_label = "if_then_" + nl()
	els_label = "if_else_" + nl()
	fi_label = "if_fi_" + nl()

	assignee = ns()

	predicate = tac_expression(ast_if.predicate)
	predicate_not = ns()
	tacs_append(TACNot(predicate_not, predicate))

	# if(predicate)
	tacs_append(TACBt(predicate, then_label))
	tacs_append(TACBt(predicate_not, els_label))

	# then
	tacs_append(TACLabel(then_label))
	then = tac_expression(ast_if.then)
	tacs_append(TACAssign(assignee, then))
	tacs_append(TACJmp(fi_label))

	# else
	tacs_append(TACLabel(els_label))
	els = tac_expression(ast_if.els)
	tacs_append(TACAssign(assignee, els))
	tacs_append(TACJmp(fi_label))

	# fi
	tacs_append(TACLabel(fi_label))

	return assignee


def tac_while(ast_while):
	start_label = "while_start_" + nl()
	body_label = "while_body_" + nl()
	exit_label = "while_exit_" + nl()

	assignee = ns()

	tacs_append(TACJmp(start_label))
	tacs_append(TACLabel(start_label))

	predicate = tac_expression(ast_while.predicate)
	predicate_not = ns()
	tacs_append(TACNot(predicate_not, predicate))

	tacs_append(TACBt(predicate_not, exit_label))
	tacs_append(TACBt(predicate, body_label))

	tacs_append(TACLabel(body_label))
	body = tac_expression(ast_while.body)
	tacs_append(TACJmp(start_label))

	tacs_append(TACLabel(exit_label))

	tacs_append(TACDefault(assignee, "Object"))

	return assignee

def tac_block(ast_block):
	for expr in ast_block.body:
		expr = tac_expression(expr)
	return expr

def tac_binding(ast_binding):
	assignee = get_symbol(ast_binding.var)
	if ast_binding.kind == "let_binding_init":
		expr = tac_expression(ast_binding.expr)
		tacs_append(TACAssign(assignee, expr))
	if ast_binding.kind == "let_binding_no_init":
		typ = ast_binding.typ
		tacs_append(TACDefault(assignee, typ))

def tac_let(ast_let):
	assignee = ns()

	push_table()

	for binding in ast_let.bindings:
		tac_binding(binding)
		
	expr = tac_expression(ast_let.expr)
	tacs_append(TACAssign(assignee, expr))
	
	pop_table()

	return assignee

def tac_case_element(ast_case):
	raise NotImplemented("TODO CASE ELEMENT")


def tac_case(ast_case):
	raise NotImplemented("TODO CASE")

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
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_plus.e1)
	e2 = tac_expression(ast_plus.e2)

	tacs_append(TACUnbox(val1, e1))
	tacs_append(TACUnbox(val2, e2))
	tacs_append(TACPlus(result, val1, val2))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_minus(ast_minus):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_minus.e1)
	e2 = tac_expression(ast_minus.e2)

	tacs_append(TACUnbox(val1, e1))
	tacs_append(TACUnbox(val2, e2))
	tacs_append(TACMinus(result, val1, val2))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_multiply(ast_times):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_times.e1)
	e2 = tac_expression(ast_times.e2)

	tacs_append(TACUnbox(val1, e1))
	tacs_append(TACUnbox(val2, e2))
	tacs_append(TACMultiply(result, val1, val2))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_divide(ast_divide):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_divide.e1)
	e2 = tac_expression(ast_divide.e2)

	tacs_append(TACUnbox(val1, e1))
	tacs_append(TACUnbox(val2, e2))
	tacs_append(TACDivide(result, val1, val2))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_lt(ast_lt):
	raise NotImplemented("TODO LT")
	assignee = ns()
	e1 = tac_expression(ast_lt.e1)
	e2 = tac_expression(ast_lt.e2)
	tacs_append(TACLT(assignee, e1, e2))
	return assignee

def tac_le(ast_le):
	raise NotImplemented("TODO LE")
	assignee = ns()
	e1 = tac_expression(ast_le.e1)
	e2 = tac_expression(ast_le.e2)
	tacs_append(TACLEQ(assignee, e1, e2))
	return assignee

def tac_eq(ast_eq):
	raise NotImplemented("TODO EQ")
	assignee = ns()
	e1 = tac_expression(ast_eq.e1)
	e2 = tac_expression(ast_eq.e2)
	tacs_append(TACEqual(assignee, e1, e2))
	return assignee

def tac_not(ast_not):
	val = ns()
	result = ns()
	box = ns()
	box_type = "Bool"

	expr = tac_expression(ast_not.expr)

	tacs_append(TACUnbox(val, expr))
	tacs_append(TACNot(result, val))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_negate(ast_negate):
	val = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	expr = tac_expression(ast_negate.expr)

	tacs_append(TACUnbox(val, expr))
	tacs_append(TACNeg(result, val))
	tacs_append(TACBox(box, result, box_type))
	return box

def tac_int(ast_integer):
	assignee = ns()
	tacs_append(TACInt(assignee, ast_integer.constant))
	return assignee

def tac_string(ast_string):
	assignee = ns()
	tacs_append(TACString(assignee, ast_string.constant))
	return assignee

def tac_boolean(ast_boolean):
	assignee = ns()
	tacs_append(TACBool(assignee, ast_boolean.constant))
	return assignee

def tac_identifier(ast_identifier):
	assignee = ns()
	tacs_append(TACAssign(assignee, get_symbol(ast_identifier.name)))
	return assignee