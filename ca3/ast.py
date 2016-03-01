
# Classes that are used to build a representation of an AST and print the TAC
class AST(object):
    def __init__(self, classes):
        self.classes = classes

    def __str__(self):
        s = ""
        s += str(len(self.classes)) + "\n"
        for ast_class in self.classes:
            s += str(ast_class)
        return s

class ASTClass(object):
    def __init__(self, inherits, name, name_line, superclass, superclass_line, features):
        self.inherits = inherits 
        self.name = name 
        self.name_line = name_line 
        self.superclass = superclass 
        self.superclass_line = superclass_line 
        self.features = features

    def __str__(self):
        # name:identifier
        s = ""
        s += str(self.name_line) + "\n"
        s += str(self.name) + "\n"
        if (self.inherits == "inherits"):
            # inherits \n superclass:identifier
            s += "inherits" + "\n"
            s += str(self.superclass_line) + "\n"
            s += str(self.superclass) + "\n"

        if (self.inherits == "no_inherits"):
            # no_inherits \n
            s += "no_inherits" + "\n"

        # features-list \n
        s += str(len(self.features)) + "\n"
        for feature in self.features:
            s += str(feature)

        return s

class ASTFeature(object):
    def __init__(self, kind, name, name_line, formals, typ, typ_line, expr):
        self.kind = kind 
        self.name = name 
        self.name_line = name_line 
        self.formals = formals 
        self.typ = typ 
        self.typ_line = typ_line 
        self.expr = expr 

    def __str__(self):
        s = ""
        if (self.kind == "method_formals"):
            # method \n name:identifier \n formals-list \n type:identifier \n expr:exp
            s += "method" + "\n"
            s += str(self.name_line) + "\n"
            s += str(self.name) + "\n"
            s += str(len(self.formals)) + "\n"
            for formal in self.formals:
                s += str(formal)
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
            s += str(self.expr)
        if (self.kind == "method"):
            # method \n name:identifier \n type:identifier \n body:exp
            s += "method" + "\n"
            s += str(self.name_line) + "\n"
            s += str(self.name) + "\n"
            s += str(len(self.formals)) + "\n"
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
            s += str(self.expr)
        if (self.kind == "attribute_init"):
            # attribute_init \n name:identifier \n type:identifier \n init:exp
            s += "attribute_init" + "\n"
            s += str(self.name_line) + "\n"
            s += str(self.name) + "\n"
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
            s += str(self.expr)
        if (self.kind == "attribute_no_init"):
            # attribute_no_init \n name:identifier \n type:identifier
            s += "attribute_no_init" + "\n"
            s += str(self.name_line) + "\n"
            s += str(self.name) + "\n"
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
        return s

class ASTFormal(object):
    def __init__(self, name, name_line, typ, typ_line):
       self.name = name 
       self.name_line = name_line 
       self.typ = typ 
       self.typ_line = typ_line 

    def __str__(self):
        # name:identifier \n type:identifier
        s = ""
        s += str(self.name_line) + "\n"
        s += str(self.name) + "\n"
        s += str(self.typ_line) + "\n"
        s += str(self.typ) + "\n"
        return s

class ASTExpression(object):
    pass

class ASTAssign(ASTExpression):
    def __init__(self, lineno, var, var_line, rhs):
        self.lineno = lineno
        self.var = var
        self.var_line = var_line
        self.rhs = rhs

    def __str__(self):
        # assign \n var:identifier rhs:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "assign" + "\n"
        s += str(self.var_line) + "\n"
        s += str(self.var) + "\n"
        s += str(self.rhs)
        return s

class ASTDynamicDispatch(ASTExpression):
    def __init__(self, lineno, expr, method, method_line, args):
        self.lineno = lineno
        self.expr = expr
        self.method = method
        self.method_line = method_line
        self.args = args

    def __str__(self):
        # dynamic_dispatch \n e:exp method:identifier args:exp-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "dynamic_dispatch" + "\n"
        s += str(self.expr)
        s += str(self.method_line) + "\n"
        s += str(self.method) + "\n"
        s += str(len(self.args)) + "\n"
        for arg in self.args:
            s += str(arg)
        return s


class ASTStaticDispatch(ASTExpression):
    def __init__(self, lineno, expr, typ, typ_line, method, method_line, args):
        self.lineno = lineno
        self.expr = expr
        self.typ = typ
        self.typ_line = typ_line
        self.method = method
        self.method_line = method_line
        self.args = args

    def __str__(self):
        # static_dispatch \n e:exp type:identifier method:identifier args:exp-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "static_dispatch" + "\n"
        s += str(self.expr)
        s += str(self.typ_line) + "\n"
        s += str(self.typ) + "\n"
        s += str(self.method_line) + "\n"
        s += str(self.method) + "\n"
        s += str(len(self.args)) + "\n"
        for arg in self.args:
            s += str(arg)
        return s

class ASTSelfDispatch(ASTExpression):
    def __init__(self, lineno, method, method_line, args):
        self.lineno = lineno
        self.method = method
        self.method_line = method_line
        self.args = args

    def __str__(self):
        # self_dispatch \n method:identifier args:exp-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "self_dispatch" + "\n"
        s += str(self.method_line) + "\n"
        s += str(self.method) + "\n"
        s += str(len(self.args)) + "\n"
        for arg in self.args:
            s += str(arg)
        return s

class ASTIf(ASTExpression):
    def __init__(self, lineno, predicate, then, els):
       self.lineno = lineno
       self.predicate = predicate
       self.then = then
       self.els = els

    def __str__(self):
        # if \n predicate:exp then:exp else:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "if" + "\n"
        s += str(self.predicate)
        s += str(self.then)
        s += str(self.els)
        return s

class ASTWhile(ASTExpression):
    def __init__(self, lineno, predicate, body):
       self.lineno = lineno
       self.predicate = predicate
       self.body = body

    def __str__(self):
        # while \n predicate:exp body:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "while" + "\n"
        s += str(self.predicate)
        s += str(self.body)
        return s

class ASTBlock(ASTExpression):
    def __init__(self, lineno, body):
       self.lineno = lineno
       self.body = body

    def __str__(self):
        # block \n body:exp-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "block" + "\n"
        s += str(len(self.body)) + "\n"
        for expr in self.body:
            s += str(expr)
        return s

class ASTBinding(object):
    def __init__(self, kind, var, var_line, typ, typ_line, expr):
        self.kind = kind
        self.var = var
        self.var_line = var_line
        self.typ = typ
        self.typ_line = typ_line
        self.expr = expr

    def __str__(self):
        s = ""
        if self.kind == 'let_binding_init':
            # let_binding_init \n variable:identifier type:identifier value:exp
            s += "let_binding_init" + "\n"
            s += str(self.var_line) + "\n"
            s += str(self.var) + "\n"
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
            s += str(self.expr)
        if self.kind == 'let_binding_no_init':
            # let_binding_no_init \n variable:identifier type:identifier
            s += "let_binding_no_init" + "\n"
            s += str(self.var_line) + "\n"
            s += str(self.var) + "\n"
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
        return s

class ASTLet(ASTExpression):
    def __init__(self, lineno, bindings, expr):
        self.lineno = lineno
        self.bindings = bindings
        self.expr = expr

    def __str__(self):
        # let \n binding-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "let" + "\n"
        s += str(len(self.bindings)) + "\n"
        for binding in self.bindings:
            s += str(binding)
        s += str(self.expr)
        return s

class ASTCaseElement(object):
    def __init__(self, var, var_line, typ, typ_line, body):
        self.var = var
        self.var_line = var_line
        self.typ = typ
        self.typ_line = typ_line
        self.body = body

    def __str__(self):
        # variable:identifier type:identifier body:exp
        s = ""
        s += str(self.var_line) + "\n"
        s += str(self.var) + "\n"
        s += str(self.typ_line) + "\n"
        s += str(self.typ) + "\n"
        s += str(self.body)
        return s

class ASTCase(ASTExpression):
    def __init__(self, lineno, expr, cases):
        self.lineno = lineno
        self.expr = expr
        self.cases = cases

    def __str__(self):
        # case \n expr cases-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "case" + "\n"
        s += str(self.expr)
        s += str(len(self.cases)) + "\n"
        for case in self.cases:
            s += str(case)
        return s

class ASTNew(ASTExpression):
    def __init__(self, lineno, typ, typ_line):
        self.lineno = lineno
        self.typ = typ
        self.typ_line = typ_line

    def __str__(self):
        # new \n class:identifier
        s = ""
        s += str(self.lineno) + "\n"
        s += "new" + "\n"
        s += str(self.typ_line) + "\n"
        s += str(self.typ) + "\n"
        return s

class ASTIsVoid(ASTExpression):
    def __init__(self, lineno, expr):
        self.lineno = lineno
        self.expr = expr

    def __str__(self):
        # isvoid \n e:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "isvoid" + "\n"
        s += str(self.expr)
        return s

class ASTBinOp(ASTExpression):
    def __init__(self, lineno, operation, e1, e2):
        self.lineno = lineno
        self.operation = operation
        self.e1 = e1
        self.e2 = e2

    def __str__(self):
        # op \n x:exp y:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += str(self.operation) + "\n"
        s += str(self.e1)
        s += str(self.e2)
        return s

class ASTBoolOp(ASTExpression):
    def __init__(self, lineno, operation, e1, e2):
        self.lineno = lineno
        self.operation = operation
        self.e1 = e1
        self.e2 = e2

    def __str__(self):
        # op \n x:exp y:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += str(self.operation) + "\n"
        s += str(self.e1)
        s += str(self.e2)
        return s

class ASTNot(ASTExpression):
    def __init__(self, lineno, expr):
        self.lineno = lineno
        self.expr = expr

    def __str__(self):
        # not \n x:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "not" + "\n"
        s += str(self.expr)
        return s

class ASTNegate(ASTExpression):
    def __init__(self, lineno, expr):
        self.lineno = lineno
        self.expr = expr

    def __str__(self):
        # not \n x:exp
        s = ""
        s += str(self.lineno) + "\n"
        s += "negate" + "\n"
        s += str(self.expr)
        return s

class ASTInteger(ASTExpression):
    def __init__(self, lineno, constant):
        self.lineno = lineno
        self.constant = constant

    def __str__(self):
        # integer \n the_integer_constant \n
        s = ""
        s += str(self.lineno) + "\n"
        s += "integer" + "\n"
        s += str(self.constant) + "\n"
        return s

class ASTString(ASTExpression):
    def __init__(self, lineno, constant):
        self.lineno = lineno
        self.constant = constant

    def __str__(self):
        # string \n the_string_constant \n
        s = ""
        s += str(self.lineno) + "\n"
        s += "string" + "\n"
        s += str(self.constant) + "\n"
        return s

class ASTBoolean(ASTExpression):
    def __init__(self, lineno, constant):
        self.lineno = lineno
        self.constant = constant

    def __str__(self):
        # true | false \n
        s = ""
        s += str(self.lineno) + "\n"
        s += str(self.constant) + "\n"
        return s

class ASTIdentifier(ASTExpression):
    def __init__(self, lineno, name, name_line):
        self.lineno = lineno
        self.name = name
        self.name_line = name_line

    def __str__(self):
        # identifier \n variable:identifier
        s = ""
        s += str(self.lineno) + "\n"
        s += "identifier" + "\n"
        s += str(self.name_line) + "\n"
        s += str(self.name) + "\n"
        return s