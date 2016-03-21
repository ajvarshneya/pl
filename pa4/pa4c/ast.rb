# Classes defining an object representation of the AST

class ClassMap
    attr_accessor :classes, :basic_classes, :all_classes
    def initialize(classes)
        @classes = classes
        @basic_classes = [ObjectClass.new(), IOClass.new(), IntClass.new(), StringClass.new(), BoolClass.new()]
        @all_classes = @basic_classes + @classes
        @all_classes = @all_classes.sort_by{|x| x.name}
    end

    def to_s()
        # class_map \n
        s = "class_map\n"
        # number of classes \n
        s += @all_classes.length().to_s() + "\n"

        for ast_class in @all_classes
            # class name \n
            s += ast_class.name + "\n"
            num_attributes = 0
            attributes = ""
            for attribute in ast_class.parent_attributes + ast_class.attributes
                if attribute.kind == "attribute_init" 
                    num_attributes += 1
                    # initializer \n attribute name \n type \n expr
                    attributes += "initializer\n"
                    attributes += attribute.name + "\n"
                    attributes += attribute.typ + "\n"
                    attributes += attribute.expr.to_s()
                end

                if attribute.kind == "attribute_no_init"
                    num_attributes += 1
                    # no_initializer \n attribute name \n type \n
                    attributes += "no_initializer\n"
                    attributes += attribute.name + "\n"
                    attributes += attribute.typ + "\n"
                end
            end
            # number of attributes \n
            s += num_attributes.to_s() + "\n"

            # attributes
            s += attributes
        end
        return s
    end
end

class ImplementationMap
    attr_accessor :all_classes, :map
    def initialize(all_classes)
        @all_classes = all_classes
        init_map()
    end

    def init_map()
        @map = {}

        for ast_class in @all_classes
            # get methods
            methods_to_print = []
            for method in (ast_class.parent_methods + ast_class.methods)
                if methods_to_print.select{|x| x.name == method.name} == []
                    methods_to_print << method
                else 
                    i = 0
                    for m in methods_to_print
                        if m.name == method.name
                            break
                        end
                        i = i + 1
                    end
                    methods_to_print[i] = method
                end
            end

            # map class name to list of methods
            @map[ast_class.name] = methods_to_print
        end
    end

    def to_s()
        # implementation_map \n
        s = "implementation_map\n"
        # number of classes \n
        s += @all_classes.length.to_s() + "\n"
        for ast_class_name in @map.keys.sort()
            # class name \n
            s += ast_class_name + "\n"
            # number of methods \n
            s += @map[ast_class_name].length.to_s() + "\n"
            for method in @map[ast_class_name]
                # name of method \n
                s += method.name + "\n"
                # number of formals \n
                s += method.formals.length.to_s() + "\n"
                for formal in method.formals
                    # name of formal \n
                    s += formal.name + "\n"
                end
                # class where method was defined \n
                s += method.associated_class + "\n"
                # method body expression
                s += method.expr.to_s()
            end
        end
        return s
    end
end

class ParentMap
    attr_accessor :all_classes, :map
    def initialize(all_classes)
        @all_classes = all_classes
        init_map()
    end

    def init_map()
        @map = {}
        for ast_class in @all_classes
            if ast_class.name != "Object"
                if ast_class.superclass != nil
                    @map[ast_class.name] = ast_class.superclass
                else
                    @map[ast_class.name] = "Object"
                end
            end
        end
    end

    def to_s()
        s = "parent_map\n"
        s += (@all_classes.length - 1).to_s() + "\n"
        for ast_class_name in @map.keys.sort()
            s += ast_class_name + "\n"
            s += @map[ast_class_name] + "\n"
        end
        return s
    end
end

# Annotated AST
class AnnotatedAST
    attr_accessor :classes
    def initialize(classes)
        @classes = classes
    end

    def to_s()
        s = @classes.length().to_s() + "\n"
        for ast_class in @classes
            s += ast_class.to_s()
        end
        return s
    end
end 

class AST
    attr_accessor :classes
    def initialize(classes)
        @classes = classes
    end

    def to_s()
        s = @classes.length().to_s() + "\n"
        for ast_class in @classes
            s += ast_class.to_s()
        end
        return s
    end
end

class ASTClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :parent_attributes, :parent_methods, :attributes, :methods
	def initialize(inherits, name, name_line, superclass, superclass_line, features)
        @inherits = inherits 
        @name = name 
        @name_line = name_line 
        @superclass = superclass 
        @superclass_line = superclass_line 
        @features = features

        # Used by type checking maps
        @parent_attributes = []
        @parent_methods = []
        @attributes = []
        @methods = []

        init_methods()
        init_attributes()
	end

	def to_s()
        # name:identifier
        s = @name_line.to_s() + "\n"
        s += @name + "\n"
        if @inherits == "inherits"
            # inherits \n superclass:identifier
            s += "inherits" + "\n"
            s += @superclass_line.to_s() + "\n"
            s += @superclass + "\n"
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

    def init_methods()
        for feature in @features
            if feature.kind == "method" or feature.kind == "method_formals"
                @methods << feature
            end
        end
    end

    def init_attributes()
        for feature in @features
            if feature.kind == "attribute_init" or feature.kind == "attribute_no_init"
                @attributes << feature 
            end
        end
    end
end

class BasicClass
    def initialize()
        # Used by type checking maps
        @parent_attributes = []
        @parent_methods = []
        @attributes = []
        @methods = []

        init_methods()
        init_attributes()
    end

    def init_methods()
        for feature in @features
            if feature.kind == "method" or feature.kind == "method_formals"
                @methods << feature
            end
        end
    end

    def init_attributes()
        for feature in @features
            if feature.kind == "attribute_init" or feature.kind == "attribute_no_init"
                @attributes << feature 
            end
        end
    end
end

class ObjectClass < BasicClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :attributes, :methods

    def initialize()
        @inherits =  "no_inherits"
        @name = "Object"
        @name_line = "0"
        @superclass = nil
        @superclass_line = nil

        abort_body = ASTInternal.new("Object", "Object.abort")
        abort_formals = []
        abort_method = ASTFeature.new("method", "abort", "0", abort_formals, "Object", "0", abort_body)
        
        copy_body = ASTInternal.new("SELF_TYPE", "Object.copy")
        copy_formals = []
        copy_method = ASTFeature.new("method", "copy", "0", copy_formals, "Object", "0", copy_body)

        type_name_body = ASTInternal.new("String", "Object.type_name")
        type_name_formals = []
        type_name_method = ASTFeature.new("method", "type_name", "0", type_name_formals, "Object", "0", type_name_body)

        @features = [abort_method, copy_method, type_name_method]
        super()
    end
end

class IOClass < BasicClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :attributes, :methods
    def initialize()
        @inherits =  "no_inherits"
        @name = "IO"
        @name_line = "0"
        @superclass = nil
        @superclass_line = nil

        in_int_body = ASTInternal.new("Int", "IO.in_int")
        in_int_formals = []
        in_int_method = ASTFeature.new("method", "in_int", "0", in_int_formals, "Object", "0", in_int_body)

        in_string_body = ASTInternal.new("String", "IO.in_string")
        in_string_formals = []
        in_string_method = ASTFeature.new("method", "in_string", "0", in_string_formals, "Object", "0", in_string_body)
        
        out_int_body = ASTInternal.new("SELF_TYPE", "IO.out_int")
        out_int_formals = [ASTFormal.new("x", "0", "Int", "0")]
        out_int_method = ASTFeature.new("method_formals", "out_int", "0", out_int_formals, "Object", "0", out_int_body)
        
        out_string_body = ASTInternal.new("SELF_TYPE", "IO.out_string")
        out_string_formals = [ASTFormal.new("x", "0", "String", "0")]
        out_string_method = ASTFeature.new("method_formals", "out_string", "0", out_string_formals, "Object", "0", out_string_body)

        @features = [in_int_method, in_string_method, out_int_method, out_string_method]
        super()
    end

end

class IntClass < BasicClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :attributes, :methods
    def initialize()
        @inherits =  "no_inherits"
        @name = "Int"
        @name_line = "0"
        @superclass = nil
        @superclass_line = nil
        @features = []

        super()
    end
end

class StringClass < BasicClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :attributes, :methods
    def initialize()
        @inherits =  "no_inherits"
        @name = "String"
        @name_line = "0"
        @superclass = nil
        @superclass_line = nil

        concat_body = ASTInternal.new("String", "String.concat")
        concat_formals = [ASTFormal.new("s", "0", "String", "0")]
        concat_method = ASTFeature.new("method_formals", "concat", "0", concat_formals, "String", "0", concat_body)

        length_body = ASTInternal.new("Int", "String.length")
        length_formals = []
        length_method = ASTFeature.new("method", "length", "0", length_formals, "Int", "0", length_body)
        
        substr_body = ASTInternal.new("String", "String.substr")
        substr_formals = [ASTFormal.new("i", "0", "Int", "0"), ASTFormal.new("l", "0", "Int", "0")]
        substr_method = ASTFeature.new("method_formals", "substr", "0", substr_formals, "String", "0", substr_body)

        @features = [concat_method, length_method, substr_method]

        super()
    end
end

class BoolClass < BasicClass
    attr_accessor :inherits, :name, :name_line, :superclass, :superclass_line, :features, :parent_attributes, :parent_methods, :attributes, :methods
    def initialize()
        @inherits =  "no_inherits"
        @name = "Bool"
        @name_line = "0"
        @superclass = nil
        @superclass_line = nil
        @features = []

        super()
    end
end

class ASTFeature
    attr_accessor :kind, :name, :name_line, :formals, :typ, :typ_line, :expr, :associated_class
    def initialize(kind, name, name_line, formals, typ, typ_line, expr)
        @kind = kind 
        @name = name 
        @name_line = name_line 
        @formals = formals 
        @typ = typ 
        @typ_line = typ_line 
        @expr = expr
        @associated_class = nil
    end

    def to_s()
        s = ""
        if @kind == "method_formals"
            # method \n name:identifier \n formals-list \n type:identifier \n expr:exp
            s += "method" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name + "\n"
            s += @formals.length().to_s() + "\n"
            for formal in @formals
                s += formal.to_s()
            end
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
            s += @expr.to_s()
        end

        if @kind == "method"
            # method \n name:identifier \n type:identifier \n body:exp
            s += "method" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name + "\n"
            s += @formals.length().to_s() + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
            s += @expr.to_s()
        end

        if @kind == "attribute_init"
            # attribute_init \n name:identifier \n type:identifier \n init:exp
            s += "attribute_init" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
            s += @expr.to_s()
        end

        if @kind == "attribute_no_init"
            # attribute_no_init \n name:identifier \n type:identifier
            s += "attribute_no_init" + "\n"
            s += @name_line.to_s() + "\n"
            s += @name + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
        end
        return s
    end
end

class ASTFormal
    attr_accessor :name, :name_line, :typ, :typ_line
    def initialize(name, name_line, typ, typ_line)
       @name = name 
       @name_line = name_line 
       @typ = typ 
       @typ_line = typ_line
    end

    def name
        return @name
    end

    def to_s()
        # name:identifier \n type:identifier
        s = @name_line.to_s() + "\n"
        s += @name + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ + "\n"
        return s
    end

end

class ASTExpression
    attr_accessor :static_type
end

class ASTAssign < ASTExpression
    attr_accessor :lineno, :var, :var_line, :rhs
    def initialize(lineno, var, var_line, rhs)
        @lineno = lineno
        @var = var
        @var_line = var_line
        @rhs = rhs
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # assign \n var:identifier rhs:exp
        s += "assign" + "\n"
        s += @var_line.to_s() + "\n"
        s += @var + "\n"
        s += @rhs.to_s()
        return s
    end
end

class ASTDynamicDispatch < ASTExpression
    attr_accessor :lineno, :expr, :method, :method_line, :args
    def initialize(lineno, expr, method, method_line, args)
        @lineno = lineno
        @expr = expr
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # dynamic_dispatch \n e:exp method:identifier args:exp-list
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
    attr_accessor :lineno, :expr, :typ, :typ_line, :method, :method_line, :args
    def initialize(lineno, expr, typ, typ_line, method, method_line, args)
        @lineno = lineno
        @expr = expr
        @typ = typ
        @typ_line = typ_line
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # static_dispatch \n e:exp type:identifier method:identifier args:exp-list
        s += "static_dispatch" + "\n"
        s += @expr.to_s()
        s += @typ_line.to_s() + "\n"
        s += @typ + "\n"
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
    attr_accessor :lineno, :method, :method_line, :args
    def initialize(lineno, method, method_line, args)
        @lineno = lineno
        @method = method
        @method_line = method_line
        @args = args
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # self_dispatch \n method:identifier args:exp-list
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
    attr_accessor :lineno, :predicate, :thn, :els
    def initialize(lineno, predicate, thn, els)
       @lineno = lineno
       @predicate = predicate
       @thn = thn
       @els = els
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # if \n predicate:exp then:exp else:exp
        s += "if" + "\n"
        s += @predicate.to_s()
        s += @thn.to_s()
        s += @els.to_s()
        return s
    end
end

class ASTWhile < ASTExpression
    attr_accessor :lineno, :predicate, :body
    def initialize(lineno, predicate, body)
       @lineno = lineno
       @predicate = predicate
       @body = body
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # while \n predicate:exp body:exp
        s += "while" + "\n"
        s += @predicate.to_s()
        s += @body.to_s()
        return s
    end
end

class ASTBlock < ASTExpression
    attr_accessor :lineno, :body
    def initialize(lineno, body)
       @lineno = lineno
       @body = body
   	end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # block \n body:exp-list
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

    def to_s()
        s = ""
        if @kind == 'let_binding_init'
            # let_binding_init \n variable:identifier type:identifier value:exp
            s += "let_binding_init" + "\n"
            s += @var_line.to_s() + "\n"
            s += @var + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
            s += @expr.to_s()
        end

        if @kind == 'let_binding_no_init'
            # let_binding_no_init \n variable:identifier type:identifier
            s += "let_binding_no_init" + "\n"
            s += @var_line.to_s() + "\n"
            s += @var + "\n"
            s += @typ_line.to_s() + "\n"
            s += @typ + "\n"
        end

        return s
    end
end

class ASTLet < ASTExpression
    attr_accessor :lineno, :bindings, :expr
    def initialize(lineno, bindings, expr)
        @lineno = lineno
        @bindings = bindings
        @expr = expr
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # let \n binding-list
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

    def to_s()
        # variable:identifier type:identifier body:exp
        s = @var_line.to_s() + "\n"
        s += @var + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ + "\n"
        s += @body.to_s()
        return s
    end
end

class ASTCase < ASTExpression
    attr_accessor :lineno, :expr, :cases
    def initialize(lineno, expr, cases)
        @lineno = lineno
        @expr = expr
        @cases = cases
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # case \n expr cases-list
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
    attr_accessor :lineno, :typ, :typ_line
    def initialize(lineno, typ, typ_line)
        @lineno = lineno
        @typ = typ
        @typ_line = typ_line
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # new \n class:identifier
        s += "new" + "\n"
        s += @typ_line.to_s() + "\n"
        s += @typ + "\n"
        return s
    end
end

class ASTIsVoid < ASTExpression
    attr_accessor :lineno, :expr
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # isvoid \n e:exp
        s += "isvoid" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTBinOp < ASTExpression
    attr_accessor :lineno, :operation, :e1, :e2
    def initialize(lineno, operation, e1, e2)
        @lineno = lineno
        @operation = operation
        @e1 = e1
        @e2 = e2
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # op \n x:exp y:exp
        s += @operation.to_s() + "\n"
        s += @e1.to_s()
        s += @e2.to_s()
        return s
    end
end

class ASTBoolOp < ASTExpression
    attr_accessor :lineno, :operation, :e1, :e2
    def initialize(lineno, operation, e1, e2)
        @lineno = lineno
        @operation = operation
        @e1 = e1
        @e2 = e2
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # op \n x:exp y:exp
        s += @operation.to_s() + "\n"
        s += @e1.to_s()
        s += @e2.to_s()
        return s
    end
end

class ASTNot < ASTExpression
    attr_accessor :lineno, :expr
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # not \n x:exp
        s += "not" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTNegate < ASTExpression
    attr_accessor :lineno, :expr
    def initialize(lineno, expr)
        @lineno = lineno
        @expr = expr
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # not \n x:exp
        s += "negate" + "\n"
        s += @expr.to_s()
        return s
    end
end

class ASTInteger < ASTExpression
    attr_accessor :lineno, :constant
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # integer \n the_integer_constant \n
        s += "integer" + "\n"
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTString < ASTExpression
    attr_accessor :lineno, :constant
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # string \n the_string_constant \n
        s += "string" + "\n"
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTBoolean < ASTExpression
    attr_accessor :lineno, :constant
    def initialize(lineno, constant)
        @lineno = lineno
        @constant = constant
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # true | false \n
        s += @constant.to_s() + "\n"
        return s
    end
end

class ASTIdentifier < ASTExpression
    attr_accessor :lineno, :name, :name_line
    def initialize(lineno, name, name_line)
        @lineno = lineno
        @name = name
        @name_line = name_line
    end

    def to_s()
        s = @lineno.to_s() + "\n"
        if @static_typ != nil
            s += @static_typ + "\n"
        end

        # identifier \n variable:identifier
        s += "identifier" + "\n"
        s += @name_line.to_s() + "\n"
        s += @name + "\n"
        return s
    end
end

class ASTInternal < ASTExpression
    attr_accessor :expr_typ, :class_method
    def initialize(expr_typ, class_method)
        @expr_typ = expr_typ
        @class_method = class_method
    end

    def to_s()
        s = "0\n"
        s += @expr_typ + "\n"
        s += "internal\n"
        s += @class_method.to_s() + "\n"
        return s
    end
end