from tacs import *
from ast import *
from ast_gen import *

symbol_counter = 0
label_counter = 0
symbol_tables = []
current_class = None
string_list = []

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

# Returns symbol if in symbol table
def get_symbol(identifier):
	global symbol_tables
	for symbol_table in reversed(symbol_tables):
		if identifier in symbol_table:
			return symbol_table[identifier]
	return None

def add_symbol(identifier):
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

def tac_method(class_name, ast_feature):
	# New scope
	push_table()

	# New tac list
	tac = []
	tac += [TACLabel(class_name + "_" + ast_feature.name + "_" + nl())]
	tac += [TACComment("Start of method " + class_name + "_" + ast_feature.name)]

	# Generate tac for method body
	expr = tac_expression(ast_feature.expr, tac)
	
	tac += [TACReturn(expr)]
	tac += [TACComment("End of method " + class_name + "_" + ast_feature.name)]

	# End scope
	pop_table()

	return tac

def tac_method_formals(class_name, ast_feature):
	# New scope
	push_table()

	# New tac list
	tac = []
	tac += [TACLabel(class_name + "_" + ast_feature.name + "_" + nl())]
	tac += [TACComment("Start of method " + class_name + "_" + ast_feature.name)]

	# Dispatch handles generating TAC for the formals before call
	# However, we have to create an entry point for our actual parameters to be used in the method (formal parameters)
	# Move actual parameters from the stack to access them
	for idx, formal in enumerate(ast_feature.formals):
		assignee = add_symbol(formal.name)
		tac += [TACLoadParam(assignee, idx, formal.typ)]

	# Generate tac for method body
	expr = tac_expression(ast_feature.expr, tac)
	tac += [TACReturn(expr)]
	tac += [TACComment("End of method " + class_name + "_" + ast_feature.name)]

	# End scope
	pop_table()

	return tac

def tac_attribute_init(class_name, ast_feature):
	tac = []
	
	tac += [TACComment("Start of attribute init " + class_name + "_" + ast_feature.name)]

	# Generate TAC for attribute expression
	expr = tac_expression(ast_feature.expr, tac)

	# Assign to identifier
	tac += [TACStoreAttribute(ast_feature.name, expr, ast_feature.typ)]
	tac += [TACComment("End of attribute init " + class_name + "_" + ast_feature.name)]

	return tac

def tac_expression(ast_expression, tac):
	if isinstance(ast_expression, ASTAssign):
		return tac_assign(ast_expression, tac)

	elif isinstance(ast_expression, ASTDynamicDispatch): # Not tested
		return tac_dynamic_dispatch(ast_expression, tac)
	elif isinstance(ast_expression, ASTStaticDispatch): # Not tested
		return tac_static_dispatch(ast_expression, tac)

	elif isinstance(ast_expression, ASTSelfDispatch):
		return tac_self_dispatch(ast_expression, tac)
	elif isinstance(ast_expression, ASTIf):
		return tac_if(ast_expression, tac)
	elif isinstance(ast_expression, ASTWhile):
		return tac_while(ast_expression, tac)
	elif isinstance(ast_expression, ASTBlock):
		return tac_block(ast_expression, tac)
	elif isinstance(ast_expression, ASTLet):
		return tac_let(ast_expression, tac)
	elif isinstance(ast_expression, ASTCase):
		return tac_case(ast_expression, tac)
	elif isinstance(ast_expression, ASTNew):
		return tac_new(ast_expression, tac)
	elif isinstance(ast_expression, ASTIsVoid):
		return tac_isvoid(ast_expression, tac)

	elif isinstance(ast_expression, ASTBinOp):
		if ast_expression.operation == "plus":
			return tac_plus(ast_expression, tac)
		if ast_expression.operation == "minus":
			return tac_minus(ast_expression, tac)
		if ast_expression.operation == "times":
			return tac_multiply(ast_expression, tac)
		if ast_expression.operation == "divide":
			return tac_divide(ast_expression, tac)

	elif isinstance(ast_expression, ASTBoolOp):
		if ast_expression.operation == "lt":
			return tac_lt(ast_expression, tac)
		if ast_expression.operation == "le":
			return tac_le(ast_expression, tac)
		if ast_expression.operation == "eq":
			return tac_eq(ast_expression, tac)

	elif isinstance(ast_expression, ASTNot):
		return tac_not(ast_expression, tac)
	elif isinstance(ast_expression, ASTNegate):
		return tac_negate(ast_expression, tac)
	elif isinstance(ast_expression, ASTInteger):
		return tac_int(ast_expression, tac)
	elif isinstance(ast_expression, ASTString):
		return tac_string(ast_expression, tac)
	elif isinstance(ast_expression, ASTBoolean):
		return tac_boolean(ast_expression, tac)
	elif isinstance(ast_expression, ASTIdentifier):
		return tac_identifier(ast_expression, tac)

def tac_assign(ast_assign, tac):
	assignee = get_symbol(ast_assign.var)
	expr = tac_expression(ast_assign.rhs, tac)
	if assignee == None:
		tac += [TACStoreAttribute(ast_assign.var, expr, ast_assign.static_type)]
		return expr
	else:
		tac += [TACAssign(assignee, expr, ast_assign.static_type)]
		return assignee

def tac_dynamic_dispatch(ast_dynamic_dispatch, tac):
	assignee = ns()
	method_name = ast_dynamic_dispatch.method
	static_type = ast_dynamic_dispatch.static_type

	# Evaluate parameters, get their virtual registers
	params = []
	for idx, arg in enumerate(ast_dynamic_dispatch.args):
		param = tac_expression(arg, tac)
		params += [param]
		tac += [TACStoreParam(idx, param)]

	# Evaluate receiver object
	receiver = tac_expression(ast_dynamic_dispatch.expr, tac)

	# Dispatch call
	tac += [TACDynamicDispatch(assignee, receiver, method_name, params, ast_dynamic_dispatch.expr.static_type)]

	return assignee

def tac_static_dispatch(ast_static_dispatch, tac):
	assignee = ns()
	method_name = ast_static_dispatch.method
	static_type = ast_static_dispatch.typ

	# Evaluate parameters, get their virtual registers
	params = []
	for idx, arg in enumerate(ast_static_dispatch.args):
		param = tac_expression(arg, tac)
		params += [param]
		tac += [TACStoreParam(idx, param)]

	# Evaluate receiver object
	receiver = tac_expression(ast_static_dispatch.expr, tac)

	# Dispatch call
	tac += [TACStaticDispatch(assignee, receiver, method_name, params, static_type)]

	return assignee

def tac_self_dispatch(ast_self_dispatch, tac):
	assignee = ns()
	method_name = ast_self_dispatch.method
	static_type = ast_self_dispatch.static_type

	# Evaluate parameters, get their virtual registers
	params = []
	for idx, arg in enumerate(ast_self_dispatch.args):
		param = tac_expression(arg, tac)
		params += [param]
		tac += [TACStoreParam(idx, param)]

	# Dispatch call
	tac += [TACSelfDispatch(assignee, method_name, params, ast_self_dispatch.static_type)]

	return assignee

def tac_if(ast_if, tac):
	then_label = "if_then_" + nl()
	els_label = "if_else_" + nl()
	fi_label = "if_fi_" + nl()

	assignee = ns()

	predicate = tac_expression(ast_if.predicate, tac)
	predicate_not = ns()
	tac += [TACNot(predicate_not, predicate, ast_if.predicate.static_type)]

	# if(predicate)
	tac += [TACBt(predicate, then_label)]
	tac += [TACBt(predicate_not, els_label)]

	# then
	tac += [TACLabel(then_label)]
	then = tac_expression(ast_if.then, tac)
	tac += [TACAssign(assignee, then, ast_if.then.static_type)]
	tac += [TACJmp(fi_label)]

	# else
	tac += [TACLabel(els_label)]
	els = tac_expression(ast_if.els, tac)
	tac += [TACAssign(assignee, els, ast_if.els.static_type)]
	tac += [TACJmp(fi_label)]

	# fi
	tac += [TACLabel(fi_label)]

	return assignee

def tac_while(ast_while, tac):
	start_label = "while_start_" + nl()
	body_label = "while_body_" + nl()
	exit_label = "while_exit_" + nl()

	assignee = ns()

	tac += [TACJmp(start_label)]
	tac += [TACLabel(start_label)]

	predicate = tac_expression(ast_while.predicate, tac)
	predicate_not = ns()
	tac += [TACNot(predicate_not, predicate, ast_while.predicate.static_type)]

	tac += [TACBt(predicate_not, exit_label)]
	tac += [TACBt(predicate, body_label)]

	tac += [TACLabel(body_label)]
	body = tac_expression(ast_while.body, tac)
	tac += [TACJmp(start_label)]

	tac += [TACLabel(exit_label)]

	tac += [TACDefault(assignee, "Object")]

	return assignee

def tac_block(ast_block, tac):
	for expr in ast_block.body:
		expr = tac_expression(expr, tac)
	return expr

def tac_binding(ast_binding, tac):
	assignee = add_symbol(ast_binding.var)
	if ast_binding.kind == "let_binding_init":
		expr = tac_expression(ast_binding.expr, tac)
		tac += [TACAssign(assignee, expr, ast, ast_binding.typ)]
	if ast_binding.kind == "let_binding_no_init":
		typ = ast_binding.typ
		tac += [TACDefault(assignee, typ)]

def tac_let(ast_let, tac):
	assignee = ns()

	push_table()

	for binding in ast_let.bindings:
		tac_binding(binding, tac)
		
	expr = tac_expression(ast_let.expr, tac)
	tac += [TACAssign(assignee, expr, ast_let.static_type)]
	
	pop_table()

	return assignee

def tac_case_element(ast_case, tac):
	raise NotImplemented("TODO CASE ELEMENT")

def tac_case(ast_case, tac):
	raise NotImplemented("TODO CASE")

def tac_new(ast_new, tac):
	assignee = ns()
	tac += [TACNew(assignee, ast_new.typ)]
	return assignee

def tac_isvoid(ast_isvoid, tac):
	assignee = ns()
	expr = tac_expression(ast_isvoid.expr, tac)
	tac += [TACIsVoid(assignee, expr, ast_isvoid.static_type)]
	return assignee

def tac_plus(ast_plus, tac):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_plus.e1, tac)
	e2 = tac_expression(ast_plus.e2, tac)

	tac += [TACUnbox(val1, e1)]
	tac += [TACUnbox(val2, e2)]
	tac += [TACPlus(result, val1, val2, ast_plus.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_minus(ast_minus, tac):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_minus.e1, tac)
	e2 = tac_expression(ast_minus.e2, tac)

	tac += [TACUnbox(val1, e1)]
	tac += [TACUnbox(val2, e2)]
	tac += [TACMinus(result, val1, val2, ast_minus.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_multiply(ast_times, tac):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_times.e1, tac)
	e2 = tac_expression(ast_times.e2, tac)

	tac += [TACUnbox(val1, e1)]
	tac += [TACUnbox(val2, e2)]
	tac += [TACMultiply(result, val1, val2, ast_times.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_divide(ast_divide, tac):
	val1 = ns()
	val2 = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	e1 = tac_expression(ast_divide.e1, tac)
	e2 = tac_expression(ast_divide.e2, tac)

	tac += [TACUnbox(val1, e1)]
	tac += [TACUnbox(val2, e2)]
	tac += [TACDivide(result, val1, val2, ast_divide.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_not(ast_not, tac):
	val = ns()
	result = ns()
	box = ns()
	box_type = "Bool"

	expr = tac_expression(ast_not.expr, tac)

	tac += [TACUnbox(val, expr)]
	tac += [TACNot(result, val, ast_not.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_negate(ast_negate, tac):
	val = ns()
	result = ns()
	box = ns()
	box_type = "Int"

	expr = tac_expression(ast_negate.expr, tac)

	tac += [TACUnbox(val, expr)]
	tac += [TACNeg(result, val, ast_negate.static_type)]
	tac += [TACBox(box, result, box_type)]
	return box

def tac_int(ast_integer, tac):
	assignee = ns()
	tac += [TACInt(assignee, ast_integer.constant, ast_integer.static_type)]
	return assignee

def tac_string(ast_string, tac):
	global string_list

	if ast_string.constant not in string_list:
		string_list += [ast_string.constant]

	assignee = ns()
	tac += [TACString(assignee, ast_string.constant, string_list.index(ast_string.constant), ast_string.static_type)]
	return assignee

def tac_boolean(ast_boolean, tac):
	assignee = ns()
	tac += [TACBool(assignee, ast_boolean.constant, ast_boolean.static_type)]
	return assignee

def tac_identifier(ast_identifier, tac):
	assignee = ns()
	symbol = get_symbol(ast_identifier.name)
	if symbol == None:
		if ast_identifier.name == "self":
			tac += [TACSelf(assignee)]
		else:
			tac += [TACLoadAttribute(assignee, ast_identifier.name, ast_identifier.static_type)]
	else:
		tac += [TACAssign(assignee, symbol, ast_identifier.static_type)]
	return assignee