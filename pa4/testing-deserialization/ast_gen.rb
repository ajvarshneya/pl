require './ast'

def ast(raw_ast)
	# classes-list
	num_classes = raw_ast.shift().to_i()
	classes = []
	for i in 1..num_classes
		classes << ast_class(raw_ast)
	end
	return AST.new(classes)
end

def ast_class(raw_ast)
	# name:identifier
	name_line = raw_ast.shift()
	name = raw_ast.shift()

	# inherits \n
	inherits = raw_ast.shift()
	superclass = nil
	superclass_line = nil
	if inherits == "inherits"
		superclass_line = raw_ast.shift()
		superclass = raw_ast.shift()
	end

	# features-list
	num_features = raw_ast.shift().to_i()
	features = []
	for i in 1..num_features
		features << ast_feature(raw_ast)
	end
	return ASTClass.new(inherits, name, name_line, superclass, superclass_line, features)
end

def ast_feature(raw_ast)
	# feature-type \n
	kind = raw_ast.shift()

	# name:identifier
	name_line = raw_ast.shift()
	name = raw_ast.shift()

	formals = []
	expr = nil
	if kind == "method"
		# formals-list
		num_formals = raw_ast.shift().to_i()
		if num_formals > 0
			kind = "method_formals"
		end

		for i in 1..num_formals
			formals << ast_formal(raw_ast)
		end
	end

	# type:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()

	# body/init:expr
	if kind != "attribute_no_init"
		expr = ast_expression(raw_ast)
	end

	return ASTFeature.new(kind, name, name_line, formals, typ, typ_line, expr)
end

def ast_formal(raw_ast)
	# name:identifier
	name_line = raw_ast.shift()
	name = raw_ast.shift()

	# type:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()
	return ASTFormal.new(name, name_line, typ, typ_line)
end

def ast_expression(raw_ast)
	# lineno \n
	lineno = raw_ast.shift()
	# kind of expression \n
	kind = raw_ast.shift()

	if kind == "assign"
		expr = ast_assign(raw_ast, lineno)
	end
	if kind == "dynamic_dispatch"
		expr = ast_dynamic_dispatch(raw_ast, lineno)
	end
	if kind == "static_dispatch"
		expr = ast_static_dispatch(raw_ast, lineno)
	end
	if kind == "self_dispatch"
		expr = ast_self_dispatch(raw_ast, lineno)
	end
	if kind == "if"
		expr = ast_if(raw_ast, lineno)
	end
	if kind == "while"
		expr = ast_while(raw_ast, lineno)
	end
	if kind == "block"
		expr = ast_block(raw_ast, lineno)
	end
	if kind == "new"
		expr = ast_new(raw_ast, lineno)
	end
	if kind == "isvoid"
		expr = ast_isvoid(raw_ast, lineno)
	end
	if kind == "plus"
		expr = ast_plus(raw_ast, lineno)
	end
	if kind == "minus"
		expr = ast_minus(raw_ast, lineno)
	end
	if kind == "times"
		expr = ast_times(raw_ast, lineno)
	end
	if kind == "divide"
		expr = ast_divide(raw_ast, lineno)
	end
	if kind == "lt"
		expr = ast_lt(raw_ast, lineno)
	end
	if kind == "le"
		expr = ast_le(raw_ast, lineno)
	end
	if kind == "eq"
		expr = ast_eq(raw_ast, lineno)
	end
	if kind == "not"
		expr = ast_not(raw_ast, lineno)
	end
	if kind == "negate"
		expr = ast_negate(raw_ast, lineno)
	end
	if kind == "integer"
		expr = ast_integer(raw_ast, lineno)
	end
	if kind == "string"
		expr = ast_string(raw_ast, lineno)
	end
	if kind == "identifier"
		expr = ast_identifier(raw_ast, lineno)
	end
	if kind == "true"
		expr = ast_true(raw_ast, lineno)
	end
	if kind == "false"
		expr = ast_false(raw_ast, lineno)
	end
	if kind == "let"
		expr = ast_let(raw_ast, lineno)
	end
	if kind == "case"
		expr = ast_case(raw_ast, lineno)
	end
	return expr
end

def ast_assign(raw_ast, lineno)
	# var:identifier
	var_line = raw_ast.shift()
	var = raw_ast.shift()

	# rhs:exp
	rhs = ast_expression(raw_ast)
	return ASTAssign.new(lineno, var, var_line, rhs)
end

def ast_dynamic_dispatch(raw_ast, lineno)
	# e:exp
	expr = ast_expression(raw_ast)

	# method:identifier
	method_line = raw_ast.shift()
	method = raw_ast.shift()

	# args:exp-list
	num_args = raw_ast.shift().to_i()
	args = []
	for i in 1..num_args
		args << ast_expression(raw_ast)
	end
	return ASTDynamicDispatch.new(lineno, expr, method, method_line, args)
end

def ast_static_dispatch(raw_ast, lineno)
	# e:exp
	expr = ast_expression(raw_ast)

	# type:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()

	# method:identifier
	method_line = raw_ast.shift()
	method = raw_ast.shift()

	# args:exp-list
	num_args = raw_ast.shift().to_i()
	args = []
	for i in 1..num_args
		args << ast_expression(raw_ast)
	end
	return ASTStaticDispatch.new(lineno, expr, typ, typ_line, method, method_line, args)
end

def ast_self_dispatch(raw_ast, lineno)
	# method:identifier
	method_line = raw_ast.shift()
	method = raw_ast.shift()

	# args:exp-list
	num_args = raw_ast.shift().to_i()
	args = []
	for i in 1..num_args
		args << ast_expression(raw_ast)
	end
	return ASTSelfDispatch.new(lineno, method, method_line, args)
end

def ast_if(raw_ast, lineno)
	# predicate:exp
	predicate = ast_expression(raw_ast)
	# then:exp
	thn = ast_expression(raw_ast)
	# else:exp
	els = ast_expression(raw_ast)
	return ASTIf.new(lineno, predicate, thn, els)
end

def ast_while(raw_ast, lineno)
	# predicate:exp
	predicate = ast_expression(raw_ast)
	# body:exp
	body = ast_expression(raw_ast)
	return ASTWhile.new(lineno, predicate, body)
end

def ast_block(raw_ast, lineno)
	# body:exp-list
	num_exprs = raw_ast.shift().to_i()
	body = []
	for i in 1..num_exprs
		body << ast_expression(raw_ast)
	end
	return ASTBlock.new(lineno, body)
end

def ast_binding(raw_ast)
	# kind of binding
	kind = raw_ast.shift()

	# var:identifier
	var_line = raw_ast.shift()
	var = raw_ast.shift()

	# type:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()

	expr = nil

	if kind == "let_binding_init"
		# value:expr
		expr = ast_expression(raw_ast)
	end
	return ASTBinding.new(kind, var, var_line, typ, typ_line, expr)
end

def ast_let(raw_ast, lineno)
	# bindings-list
	num_bindings = raw_ast.shift().to_i()
	bindings = []
	for i in 1..num_bindings
		bindings << ast_binding(raw_ast)
	end
	expr = ast_expression(raw_ast)
	return ASTLet.new(lineno, bindings, expr)
end

def ast_case_element(raw_ast)
	# variable:identifier
	var_line = raw_ast.shift()
	var = raw_ast.shift()

	# type:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()
	
	# body:exp
	body = ast_expression(raw_ast)
	return ASTCaseElement.new(var, var_line, typ, typ_line, body)
end

def ast_case(raw_ast, lineno)
	# expr
	expr = ast_expression(raw_ast)

	# cases-list
	num_cases = raw_ast.shift().to_i()
	cases = []
	for i in 1..num_cases
		cases << ast_case_element(raw_ast)
	end
	return ASTCase.new(lineno, expr, cases)
end

def ast_new(raw_ast, lineno)
	# class:identifier
	typ_line = raw_ast.shift()
	typ = raw_ast.shift()
	return ASTNew.new(lineno, typ, typ_line)
end

def ast_isvoid(raw_ast, lineno)
	# e:exp
	expr = ast_expression(raw_ast)
	return ASTIsVoid.new(lineno, expr)
end

def ast_plus(raw_ast, lineno)
	operation = "plus"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBinOp.new(lineno, operation, e1, e2)
end

def ast_minus(raw_ast, lineno)
	operation = "minus"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBinOp.new(lineno, operation, e1, e2)
end

def ast_times(raw_ast, lineno)
	operation = "times"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBinOp.new(lineno, operation, e1, e2)
end

def ast_divide(raw_ast, lineno)
	operation = "divide"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBinOp.new(lineno, operation, e1, e2)
end

def ast_lt(raw_ast, lineno)
	operation = "lt"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBoolOp.new(lineno, operation, e1, e2)
end

def ast_le(raw_ast, lineno)
	operation = "le"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBoolOp.new(lineno, operation, e1, e2)
end

def ast_eq(raw_ast, lineno)
	operation = "eq"
	# x:exp
	e1 = ast_expression(raw_ast)
	# y:exp
	e2 = ast_expression(raw_ast)
	return ASTBoolOp.new(lineno, operation, e1, e2)
end

def ast_not(raw_ast, lineno)
	# x:exp
	expr = ast_expression(raw_ast)
	return ASTNot.new(lineno, expr)
end

def ast_negate(raw_ast, lineno)
	# x:exp
	expr = ast_expression(raw_ast)
	return ASTNegate.new(lineno, expr)
end

def ast_integer(raw_ast, lineno)
	# the_integer_constant \n
	constant = raw_ast.shift().to_i()
	return ASTInteger.new(lineno, constant)
end

def ast_string(raw_ast, lineno)
	# the_string_constant \n
	constant = raw_ast.shift()
	return ASTString.new(lineno, constant)
end

def ast_true(raw_ast, lineno)
	# true \n
	return ASTBoolean.new(lineno, "true")
end

def ast_false(raw_ast, lineno)
	# false \n
	return ASTBoolean.new(lineno, "false")
end

def ast_identifier(raw_ast, lineno)
	# variable:identifier 
	name_line = raw_ast.shift()
	name = raw_ast.shift()
	return ASTIdentifier.new(lineno, name, name_line)
end

def read_ast(filename)
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
