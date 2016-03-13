# Classes defining an object representation of the AST

class AST
	def initialize(classes)
		@classes = classes
	end

	def to_s
		s = ""
		s += @classes.length().to_s() + "\n"
		for ast_class in @classes
			s += ast_class.to_s()
		end
		return s
	end
end

class ASTClass
	def initialize(inherits, name, name_line, superclass, superclass_line, features)
       @inherits = inherits 
       @name = name 
       @name_line = name_line 
       @superclass = superclass 
       @superclass_line = superclass_line 
       @features = features
	end

	def to_s
        # name:identifier
        s = ""
        s += @name_line.to_s() + "\n"
        s += @name.to_s() + "\n"
        if @inherits == "inherits"
            # inherits \n superclass:identifier
            s += "inherits" + "\n"
            s += @superclass_line.to_s() + "\n"
            s += @superclass.to_s() + "\n"
		end

        if @inherits == "no_inherits"
            # no_inherits \n
            s += "no_inherits" + "\n"
        end

        # features-list \n
        s += @features.length().to_s() + "\n"
        for feature in @features
            s += feature.to_s()
        end
        return s
	end
end

class ASTFeature
    def initialize(kind, name, name_line, formals, typ, typ_line, expr)
        @kind = kind 
        @name = name 
        @name_line = name_line 
        @formals = formals 
        @typ = typ 
        @typ_line = typ_line 
        @expr = expr
    end

    def to_s
        s = ""
        if @kind == "method_formals"
            # method \n name:identifier \n formals-list \n type:identifier \n expr:exp
            s += "method" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name.to_s() + "\n"
            s += @formals.length().to_s() + "\n"
            for formal in @formals
                s += formal.to_s()
            end
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
            s += @expr.to_s()
        end

        if @kind == "method"
            # method \n name:identifier \n type:identifier \n body:exp
            s += "method" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name.to_s() + "\n"
            s += @formals.length().to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
            s += @expr.to_s()
        end

        if @kind == "attribute_init"
            # attribute_init \n name:identifier \n type:identifier \n init:exp
            s += "attribute_init" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name.to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
            s += @expr.to_s()
        end

        if @kind == "attribute_no_init"
            # attribute_no_init \n name:identifier \n type:identifier
            s += "attribute_no_init" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name.to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
        end
        return s
    end
end

class ASTFormal
    def initialize(name, name_line, typ, typ_line)
       @name = name 
       @name_line = name_line 
       @typ = typ 
       @typ_line = typ_line
    end

    def to_s
        # name:identifier \n type:identifier
        s = ""
        s += @name_line.to_s() + "\n"
        s += @name.to_s() + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ.to_s() + "\n"
        return s
    end
end

class ASTExpression
end

class ASTAssign < ASTExpression
    def initialize(lineno, var, var_line, rhs)
        @lineno = lineno
        @var = var
        @var_line = var_line
        @rhs = rhs
    end

    def to_s
        # assign \n var:identifier rhs:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "assign" + "\n"
        s += @var_line.to_s() + "\n"
        s += @var.to_s() + "\n"
        s += @rhs.to_s()
        return s
    end
end

class ASTDynamicDispatch < ASTExpression
    def initialize(lineno, expr, method, method_line, args)
        @lineno = lineno
        @expr = expr
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s
        # dynamic_dispatch \n e:exp method:identifier args:exp-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "dynamic_dispatch" + "\n"
        s += @expr.to_s()
        s += @method_line.to_s() + "\n"
        s += @method.to_s() + "\n"
        s += @args.length().to_s() + "\n"
        for arg in @args
            s += arg.to_s()
        end
        return s
    end
end

class ASTStaticDispatch < ASTExpression
    def initialize(lineno, expr, typ, typ_line, method, method_line, args)
        @lineno = lineno
        @expr = expr
        @typ = typ
        @typ_line = typ_line
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s
        # static_dispatch \n e:exp type:identifier method:identifier args:exp-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "static_dispatch" + "\n"
        s += @expr.to_s()
        s += @typ_line.to_s() + "\n"
        s += @typ.to_s() + "\n"
        s += @method_line.to_s() + "\n"
        s += @method.to_s() + "\n"
        s += @args.length().to_s() + "\n"
        for arg in @args
            s += arg.to_s()
        end
        return s
    end
end

class ASTSelfDispatch < ASTExpression
    def initialize(lineno, method, method_line, args)
        @lineno = lineno
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s
        # self_dispatch \n method:identifier args:exp-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "self_dispatch" + "\n"
        s += @method_line.to_s() + "\n"
        s += @method.to_s() + "\n"
        s += @args.length().to_s() + "\n"
        for arg in @args
            s += arg.to_s()
        end
        return s
    end
end

class ASTIf < ASTExpression
    def initialize(lineno, predicate, thn, els)
       @lineno = lineno
       @predicate = predicate
       @thn = thn
       @els = els
    end

    def to_s
        # if \n predicate:exp then:exp else:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "if" + "\n"
        s += @predicate.to_s()
        s += @thn.to_s()
        s += @els.to_s()
        return s
    end
end

class ASTWhile < ASTExpression
    def initialize(lineno, predicate, body)
       @lineno = lineno
       @predicate = predicate
       @body = body
    end

    def to_s
        # while \n predicate:exp body:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "while" + "\n"
        s += @predicate.to_s()
        s += @body.to_s()
        return s
    end
end

class ASTBlock < ASTExpression
    def initialize(lineno, body)
       @lineno = lineno
       @body = body
   	end

    def to_s
        # block \n body:exp-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "block" + "\n"
        s += @body.length().to_s + "\n"
        for expr in @body
            s += expr.to_s()
        end
        return s
    end
end

class ASTBinding
    def initialize(kind, var, var_line, typ, typ_line, expr)
        @kind = kind
        @var = var
        @var_line = var_line
        @typ = typ
        @typ_line = typ_line
        @expr = expr
    end

    def to_s
        s = ""
        if @kind == 'let_binding_init'
            # let_binding_init \n variable:identifier type:identifier value:exp
            s += "let_binding_init" + "\n"
            s += @var_line.to_s() + "\n"
            s += @var.to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
            s += @expr.to_s()
        end

        if @kind == 'let_binding_no_init'
            # let_binding_no_init \n variable:identifier type:identifier
            s += "let_binding_no_init" + "\n"
            s += @var_line.to_s() + "\n"
            s += @var.to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ.to_s() + "\n"
        end

        return s
    end
end

class ASTLet < ASTExpression
    def initialize(lineno, bindings, expr)
        @lineno = lineno
        @bindings = bindings
        @expr = expr
    end

    def to_s
        # let \n binding-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "let" + "\n"
        s += @bindings.length().to_s() + "\n"
        for binding in @bindings
            s += binding.to_s()
        end
        s += @expr.to_s()
        return s
    end
end

class ASTCaseElement
    def initialize(var, var_line, typ, typ_line, body)
        @var = var
        @var_line = var_line
        @typ = typ
        @typ_line = typ_line
        @body = body
    end

    def to_s
        # variable:identifier type:identifier body:exp
        s = ""
        s += @var_line.to_s() + "\n"
        s += @var.to_s() + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ.to_s() + "\n"
        s += @body.to_s()
        return s
    end
end

class ASTCase < ASTExpression
    def initialize(lineno, expr, cases)
        @lineno = lineno
        @expr = expr
        @cases = cases
    end

    def to_s
        # case \n expr cases-list
        s = ""
        s += @lineno.to_s() + "\n"
        s += "case" + "\n"
        s += @expr.to_s()
        s += @cases.length().to_s() + "\n"
        for ast_case in @cases
            s += ast_case.to_s()
        end
        return s
    end
end

class ASTNew < ASTExpression
    def initialize(lineno, typ, typ_line)
        @lineno = lineno
        @typ = typ
        @typ_line = typ_line
    end

    def to_s
        # new \n class:identifier
        s = ""
        s += @lineno.to_s() + "\n"
        s += "new" + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ.to_s() + "\n"
        return s
    end
end

class ASTIsVoid < ASTExpression
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s
        # isvoid \n e:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "isvoid" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTBinOp < ASTExpression
    def initialize(lineno, operation, e1, e2)
        @lineno = lineno
        @operation = operation
        @e1 = e1
        @e2 = e2
    end

    def to_s
        # op \n x:exp y:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += @operation.to_s() + "\n"
        s += @e1.to_s()
        s += @e2.to_s()
        return s
    end
end

class ASTBoolOp < ASTExpression
    def initialize(lineno, operation, e1, e2)
        @lineno = lineno
        @operation = operation
        @e1 = e1
        @e2 = e2
    end

    def to_s
        # op \n x:exp y:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += @operation.to_s() + "\n"
        s += @e1.to_s()
        s += @e2.to_s()
        return s
    end
end

class ASTNot < ASTExpression
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s
        # not \n x:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "not" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTNegate < ASTExpression
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s
        # not \n x:exp
        s = ""
        s += @lineno.to_s() + "\n"
        s += "negate" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTInteger < ASTExpression
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s
        # integer \n the_integer_constant \n
        s = ""
        s += @lineno.to_s() + "\n"
        s += "integer" + "\n"
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTString < ASTExpression
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s
        # string \n the_string_constant \n
        s = ""
        s += @lineno.to_s() + "\n"
        s += "string" + "\n"
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTBoolean < ASTExpression
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s
        # true | false \n
        s = ""
        s += @lineno.to_s() + "\n"
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTIdentifier < ASTExpression
    def initialize(lineno, name, name_line)
        @lineno = lineno
        @name = name
        @name_line = name_line
    end

    def to_s
        # identifier \n variable:identifier
        s = ""
        s += @lineno.to_s() + "\n"
        s += "identifier" + "\n"
        s += @name_line.to_s() + "\n"
        s += @name.to_s() + "\n"
        return s
    end
end