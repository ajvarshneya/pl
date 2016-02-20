import sys
import ply.yacc as yacc

tokens = (
    'AT',
    'CASE',
    'CLASS',
    'COLON',
    'COMMA',
    'DIVIDE',
    'DOT',
    'ELSE',
    'EQUALS',
    'ESAC',
    'FALSE',
    'FI',
    'IDENTIFIER',
    'IF',
    'IN',
    'INHERITS',
    'INTEGER',
    'ISVOID',
    'LARROW',
    'LBRACE',
    'LE',
    'LET',
    'LOOP',
    'LPAREN',
    'LT',
    'MINUS',
    'NEW',
    'NOT',
    'OF',
    'PLUS',
    'POOL',
    'RARROW',
    'RBRACE',
    'RPAREN',
    'SEMI',
    'STRING',
    'THEN',
    'TILDE',
    'TIMES',
    'TRUE',
    'TYPE',
    'WHILE',
)

precedence = (
    ('left', 'DOT'),
    ('left', 'AT'),
    ('left', 'TILDE'),
    ('left', 'ISVOID'),
    ('left', 'TIMES', 'DIVIDE'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'LE', 'LT', 'EQUALS'),
    ('left', 'NOT'),
    ('right', 'LARROW'),
)

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
        if self.features:
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
            if self.formals:
                s += str(len(self.formals)) + "\n"
                for formal in self.formals:
                    s += str(self.formals)
            s += str(self.typ_line) + "\n"
            s += str(self.typ) + "\n"
            s += str(self.expr)
        if (self.kind == "method"):
            # method \n name:identifier \n type:identifier \n body:exp
            s += "method" + "\n"
            s += str(self.name_line) + "\n"
            s += str(self.name) + "\n"
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
        if self.args:
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
        if self.args:
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
        if self.args:
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
        if self.body:
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
    def __init__(self, lineno, binding, bindings, expr):
        self.lineno = lineno
        self.binding = binding
        self.bindings = bindings
        self.expr = expr

    def __str__(self):
        # let \n binding-list
        s = ""
        s += str(self.lineno) + "\n"
        s += "let" + "\n"
        if self.bindings:
            s += str(len(self.bindings)) + "\n"
            for binding in self.bindings:
                s += str(binding)
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
        if self.cases:
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
        self.typ = typ
        self.typ_line = typ_line

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
        s += str(self.name) + "\n"
        s += str(self.name_line) + "\n"
        return s

### PROGRAM ###

# program ::= [class;]+
def p_program(p):
    'program : classes'
    p[0] = AST(p[1])

### CLASS ###
# params : inherits, name, name_line, superclass, superclass_line, features

def p_classes(p):
    # [class;]+
    'classes : class SEMI classes'
    p[0] = [p[1]] + p[3]

def p_classes_base(p):
    # [class;]
    'classes : class SEMI'
    p[0] = [p[1]]

def p_class_inherits(p):
    # class ::= class TYPE inherits TYPE { [feature;]* }
    'class : CLASS TYPE INHERITS TYPE LBRACE features RBRACE'
    p[0] = ASTClass('inherits', p[2], p.lineno(2), p[4], p.lineno(4), p[6])

def p_class_no_inherits(p):
    # class ::= class TYPE { [feature;]* }
    'class : CLASS TYPE LBRACE features RBRACE'
    p[0] = ASTClass('no_inherits', p[2], p.lineno(1), None, None, p[4])

def p_features(p):
    # features ::= [feature;]*
    'features : feature SEMI features'
    p[0] = [p[1]] + p[3]

def p_features_base(p):
    # features ::= []
    'features : '
    p[0] = []


### FEATURE ###
# params : kind, name, name_line, formals, typ, typ_line, expr/body

# feature ::= ID( [formal [, formal]*] ) : TYPE { expr }
def p_feature_method_formals(p):
    'feature : IDENTIFIER LPAREN formals RPAREN COLON TYPE LBRACE expr RBRACE'
    p[0] = ASTFeature('method_formals', p[1], p.lineno(1), p[3], p[6], p.lineno(6), p[8])

# feature ::= ID() : TYPE { expr }
def p_feature_method(p):
    'feature : IDENTIFIER LPAREN RPAREN COLON TYPE LBRACE expr RBRACE'
    p[0] = ASTFeature('method', p[1], p.lineno(1), None, p[5], p.lineno(5),  p[7])

# feature ::= ID : TYPE [ <- expr ]
def p_feature_init(p):
    'feature : IDENTIFIER COLON TYPE LARROW expr'
    p[0] = ASTFeature('attribute_init', p[1], p.lineno(1), None, p[3], p.lineno(3), p[5])

# feature ::= ID : TYPE
def p_feature(p):
    'feature : IDENTIFIER COLON TYPE'
    p[0] = ASTFeature('attribute_no_init', p[1], p.lineno(1), None, p[3], p.lineno(3), None)

# formals ::= [formal [, formal]*]
def p_formals(p):
    'formals : formal COMMA formals'
    p[0] = [p[1]] + p[3]

# formals ::= [formal]
def p_formals_base(p):
    'formals : formal'
    p[0] = [p[1]]


### FORMAL ###

# formal ::= ID : TYPE
def p_formal(p):
    'formal : IDENTIFIER COLON TYPE'
    p[0] = ASTFormal(p[1], p.lineno(1), p[3], p.lineno(3))


### EXPRESSIONS ###
# expr ::= ID <- expr
def p_expr_assign(p):
    'expr : IDENTIFIER LARROW expr'
    p[0] = ASTAssign(p.lineno(1), p[1], p.lineno(1), p[3])


# DISPATCH #

# params : expr, method, method_line, args
# expr ::= expr.ID( [expr [, expr]*] )
def p_expr_dynamic_dispatch_params(p):
    'expr : expr DOT IDENTIFIER LPAREN exprs RPAREN'
    p[0] = ASTDynamicDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5])

# expr ::= expr.ID( [expr [, expr]*] )
def p_expr_dynamic_dispatch(p):
    'expr : expr DOT IDENTIFIER LPAREN RPAREN'
    p[0] = ASTDynamicDispatch(p.lineno(1), p[1], p[3], p.lineno(3), None)

# params : expr, typ, typ_line, method, method_line, args
# expr ::= expr[@TYPE].ID( [expr [, expr]*] )
def p_expr_static_dispatch_params(p):
    'expr : expr AT TYPE DOT IDENTIFIER LPAREN exprs RPAREN'
    p[0] = ASTStaticDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5], p.lineno(5), p[7])

# expr ::= expr[@TYPE].ID( [expr [, expr]*] )
def p_expr_static_dispatch(p):
    'expr : expr AT TYPE DOT IDENTIFIER LPAREN RPAREN'
    p[0] = ASTStaticDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5], p.lineno(5), None)

# params : method, method_line, args
# expr ::= ID( [expr [, expr]*] )
def p_expr_dispatch_params(p):
    'expr : IDENTIFIER LPAREN exprs RPAREN'
    p[0] = ASTSelfDispatch(p.lineno(1), p[1], p.lineno(1), p[3])

# expr ::= ID( [expr [, expr]*] )
def p_expr_dispatch(p):
    'expr : IDENTIFIER LPAREN RPAREN'
    p[0] = ASTSelfDispatch(p.lineno(1), p[1], p.lineno(1), None)

# exprs ::= expr [, expr]*
def p_exprs(p):
    'exprs : expr COMMA exprs'
    p[0] = [p[1]] + p[3]

# exprs ::= expr
def p_exprs_base(p):
    'exprs : expr'
    p[0] = [p[1]]

# IF/WHILE/BLOCKS #

# params : lineno, predicate, then, els
# expr ::= if expr then expr else expr fi
def p_expr_if(p):
    'expr : IF expr THEN expr ELSE expr FI'
    p[0] = ASTIf(p.lineno(1), p[2], p[4], p[6])

# params : lineno, predicate, body
# expr ::= while expr loop expr pool
def p_expr_while(p):
    'expr : WHILE expr LOOP expr POOL'
    p[0] = ASTWhile(p.lineno(1), p[2], p[4])

# params : lineno, body
# expr ::= { [expr;]+ }
def p_block(p):
    'expr : LBRACE exprsemi RBRACE'
    p[0] = ASTBlock(p.lineno(1), p[2])

# exprsemi ::= [expr;]+
def p_exprsemi(p):
    'exprsemi : expr SEMI exprsemi'
    p[0] = [p[1]] + p[3]

# exprsemi ::= expr;
def p_exprsemi_base(p):
    'exprsemi : expr SEMI'
    p[0] = [p[1]]

# LET/CASE #

# params : lineno, binding, bindings, expr
# expr ::= let ID : TYPE [ <- expr ] [, ID : TYPE [<- expr]]* in expr
def p_expr_let(p):
    'expr : LET binding bindings IN expr'
    p[0] = ASTLet(p.lineno(1), p[2], p[3], p[5])

# params : kind, var, var_line, typ, typ_line, expr
# bindings ::= ID : TYPE <- expr
def p_binding_init(p):
    'binding : IDENTIFIER COLON TYPE LARROW expr'
    p[0] = ASTBinding('let_binding_init', p[1], p.lineno(1), p[3], p.lineno(3), p[5])

# bindings ::= ID : TYPE 
def p_binding_no_init(p):
    'binding : IDENTIFIER COLON TYPE'
    p[0] = ASTBinding('let_binding_no_init', p[1], p.lineno(1), p[3], p.lineno(3), None)

# bindings ::= [, ID : TYPE <- expr]*
def p_bindings_init(p):
    'bindings : COMMA IDENTIFIER COLON TYPE LARROW expr bindings'
    p[0] = [ASTBinding('let_binding_init', p[2], p.lineno(2), p[4], p.lineno(4), p[6])] + p[7] 

# bindings ::= [, ID : TYPE]*
def p_bindings_no_init(p):
    'bindings : COMMA IDENTIFIER COLON TYPE bindings'
    p[0] = [ASTBinding('let_binding_no_init', p[2], p.lineno(2), p[4], p.lineno(4), None)] + p[3] 

def p_bindings_base(p):
    'bindings : '
    p[0] = []

# params :  lineno, expr, cases
# expr ::= case expr of [ID : TYPE => expr;]+ esac
def p_expr_case(p):
    'expr : CASE expr OF cases ESAC'    
    p[0] = ASTCase(p.lineno(1), p[2], p[4])

# params : var, var_line, typ, typ_line, body
# cases ::= [ID : TYPE => expr;]+
def p_cases(p):
    'cases : IDENTIFIER COLON TYPE RARROW expr SEMI cases'
    p[0] = [ASTCaseElement(p[1], p.lineno(1), p[3], p.lineno(3), p[5])] + p[7]

# cases ::= ID : TYPE => expr;
def p_cases_base(p):
    'cases : IDENTIFIER COLON TYPE RARROW expr SEMI'
    p[0] = [ASTCaseElement(p[1], p.lineno(1), p[3], p.lineno(3), p[5])]


# EVERYTHING ELSE #

# params : lineno, typ, typ_line
# expr ::= new TYPE
def p_expr_new(p):
    'expr : NEW TYPE'
    p[0] = ASTNew(p.lineno(1), p[2], p.lineno(2))

# params : lineno, expr
# expr ::= isvoid expr
def p_expr_isvoid(p):
    'expr : ISVOID expr'
    p[0] = ASTIsVoid(p.lineno(1), p[2])

# params : lineno, operation, e1, e2
# expr ::= expr + expr
def p_expr_plus(p):
    'expr : expr PLUS expr'
    p[0] = ASTBinOp(p.lineno(1), 'plus', p[1], p[3])

# expr ::= expr - expr
def p_expr_minus(p):
    'expr : expr MINUS expr'
    p[0] = ASTBinOp(p.lineno(1), 'minus', p[1], p[3])

# expr ::= expr * expr
def p_expr_times(p):
    'expr : expr TIMES expr'
    p[0] = ASTBinOp(p.lineno(1), 'times', p[1], p[3])

# expr ::= expr / expr
def p_expr_divide(p):
    'expr : expr DIVIDE expr'
    p[0] = ASTBinOp(p.lineno(1), 'divide', p[1], p[3])

# params : lineno, operation, e1, e2
# expr ::= expr < expr
def p_expr_lt(p):
    'expr : expr LT expr'
    p[0] = ASTBoolOp(p.lineno(1), 'lt', p[1], p[3])

# expr ::= expr <= expr
def p_expr_le(p):
    'expr : expr LE expr'
    p[0] = ASTBoolOp(p.lineno(1), 'le', p[1], p[3])

# expr ::= expr = expr
def p_expr_equals(p):
    'expr : expr EQUALS expr'
    p[0] = ASTBoolOp(p.lineno(1), 'eq', p[1], p[3])

# params : lineno, expr
# expr ::= not expr
def p_expr_not(p):
    'expr : NOT expr'
    p[0] = ASTNot(p.lineno(1), p[2])

# params : lineno, expr
# expr ::= ~ expr
def p_expr_negate(p):
    'expr : TILDE expr'
    p[0] = ASTNegate(p.lineno(1), p[2])

# expr ::= (expr)
def p_expr_parens(p):
    'expr : LPAREN expr RPAREN'
    p[0] = p[2]

# params : lineno, name, name_line
# expr ::= ID
def p_expr_identifier(p):
    'expr : IDENTIFIER'
    p[0] = ASTIdentifier(p.lineno(1), p.lineno(1), p[1])

# params : lineno, constant
# expr ::= integer
def p_expr_integer(p):
    'expr : INTEGER'
    p[0] = ASTInteger(p.lineno(1), p[1])

# expr ::= string
def p_expr_string(p):
    'expr : STRING'
    p[0] = ASTString(p.lineno(1), p[1])

# expr ::= true
def p_expr_true(p):
    'expr : TRUE'
    p[0] = ASTBoolean(p.lineno(1), 'true')

# expr ::= false
def p_expr_false(p):
    'expr : FALSE'
    p[0] = ASTBoolean(p.lineno(1), 'false')

def p_error(p):
    print "Syntax error in input!"
    sys.exit()   


# Produces Token objects from input
class Lexer(object):
    def __init__(self, tokens):
        self.tokens = tokens
        self.iterator = iter(tokens)

    def token(self):
        try:
            token = next(self.iterator)
            # print token
            if len(token) == 2:
                return Token(token[0], token[1], None) 
            else:
                return Token(token[0], token[1], token[2])
        except StopIteration:
            return None

# A token class compatible with ply
class Token(object):
    def __init__(self, token_lineno, token_type, token_value):
        self.lineno = int(token_lineno)
        self.type = token_type.upper()
        self.value = token_value
        self.lexpos = None

    def __str__(self):
        return "<line: " + str(self.lineno) + ", type: " + str(self.type) + ", value: " + str(self.value) + ">"

# Groups raw input into tokens represented as tuples
def get_tokens(lexed):
    iterator = iter(lexed)

    tokens = []
    for line in iterator:
        token_lineno = line
        token_type = next(iterator)

        if (token_type == 'type' or
            token_type == 'identifier' or
            token_type == 'integer' or
            token_type == 'string'):
            token_value = next(iterator)
            token = (token_lineno, token_type, token_value)
        else:
            token = (token_lineno, token_type)

        tokens.append(token)

    return tokens

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

def write_output(filename, ast):
    f = open(filename[:-4] + "-ast", 'w')
    f.write(str(ast))

def main():
    filename = sys.argv[1]
    lexed = read_input(filename)
    token_tuples = get_tokens(lexed)

    lex = Lexer(token_tuples)
    # while (token != None):
    #     print token
    #     token = lex.token()

    # parser = yacc.yacc(errorlog=yacc.NullLogger())
    parser = yacc.yacc()
    # ast = yacc.parse(debug=True, lexer=lex)
    ast = yacc.parse(lexer=lex)
    # print ast
    write_output(filename, ast)

if __name__ == '__main__':
    main()