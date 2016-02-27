import sys
import yacc
from mylex import *
from nodes import *

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
    ('right', 'IN'),
    ('right', 'LARROW'),
    ('left', 'NOT'),
    ('nonassoc', 'LE', 'LT', 'EQUALS'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE'),
    ('left', 'ISVOID'),
    ('left', 'TILDE'),
    ('left', 'AT'),
    ('left', 'DOT'),
)

# For slightly nicer error messages
token_error_map = {
    "AT" : "@",
    "COLON" : ":",
    "COMMA" : ",",
    "DIVIDE" : "/",
    "DOT" : ".",
    "EQUALS" : "=",
    "LARROW" : "<-",
    "LBRACE" : "{",
    "LE" : "<=",
    "LPAREN" : "(",
    "LT" : "<",
    "MINUS" : "-",
    "PLUS" : "+",
    "RARROW" : "=>",
    "RBRACE" : "}",
    "RPAREN" : ")",
    "SEMI" : ";",
    "TILDE" : "~",
    "TIMES" : "*",
    "" : "< empty >"
}

# Program
# program ::= [class;]+
def p_program(p):
    'program : classes'
    p[0] = AST(p[1])

# Class
# [class;]+
def p_classes(p):
    'classes : class SEMI classes'
    p[0] = [p[1]] + p[3]

# [class;]
def p_classes_base(p):
    'classes : class SEMI'
    p[0] = [p[1]]

# class ::= class TYPE inherits TYPE { [feature;]* }
def p_class_inherits(p):
    'class : CLASS TYPE INHERITS TYPE LBRACE features RBRACE'
    p[0] = ASTClass('inherits', p[2], p.lineno(2), p[4], p.lineno(4), p[6])

# class ::= class TYPE { [feature;]* }
def p_class_no_inherits(p):
    'class : CLASS TYPE LBRACE features RBRACE'
    p[0] = ASTClass('no_inherits', p[2], p.lineno(1), [], None, p[4])

# features ::= [feature;]*
def p_features(p):
    'features : feature SEMI features'
    p[0] = [p[1]] + p[3]

# features ::= []
def p_features_base(p):
    'features : '
    p[0] = []


# Feature
# feature ::= ID( [formal [, formal]*] ) : TYPE { expr }
def p_feature_method_formals(p):
    'feature : IDENTIFIER LPAREN formals RPAREN COLON TYPE LBRACE expr RBRACE'
    p[0] = ASTFeature('method_formals', p[1], p.lineno(1), p[3], p[6], p.lineno(6), p[8])

# feature ::= ID() : TYPE { expr }
def p_feature_method(p):
    'feature : IDENTIFIER LPAREN RPAREN COLON TYPE LBRACE expr RBRACE'
    p[0] = ASTFeature('method', p[1], p.lineno(1), [], p[5], p.lineno(5),  p[7])

# feature ::= ID : TYPE [ <- expr ]
def p_feature_init(p):
    'feature : IDENTIFIER COLON TYPE LARROW expr'
    p[0] = ASTFeature('attribute_init', p[1], p.lineno(1), [], p[3], p.lineno(3), p[5])

# feature ::= ID : TYPE
def p_feature(p):
    'feature : IDENTIFIER COLON TYPE'
    p[0] = ASTFeature('attribute_no_init', p[1], p.lineno(1), [], p[3], p.lineno(3), None)

# formals ::= [formal [, formal]*]
def p_formals(p):
    'formals : formal COMMA formals'
    p[0] = [p[1]] + p[3]

# formals ::= [formal]
def p_formals_base(p):
    'formals : formal'
    p[0] = [p[1]]


# Formal
# formal ::= ID : TYPE
def p_formal(p):
    'formal : IDENTIFIER COLON TYPE'
    p[0] = ASTFormal(p[1], p.lineno(1), p[3], p.lineno(3))


# Expressions

# Assign expression
# expr ::= ID <- expr
def p_expr_assign(p):
    'expr : IDENTIFIER LARROW expr'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTAssign(p.lineno(1), p[1], p.lineno(1), p[3])


# Dynamic dispatch expression
# expr ::= expr.ID( [expr [, expr]*] )
def p_expr_dynamic_dispatch_params(p):
    'expr : expr DOT IDENTIFIER LPAREN exprs RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTDynamicDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5])

# expr ::= expr.ID()
def p_expr_dynamic_dispatch(p):
    'expr : expr DOT IDENTIFIER LPAREN RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTDynamicDispatch(p.lineno(1), p[1], p[3], p.lineno(3), [])

# Static dispatch expression
# expr ::= expr[@TYPE].ID( [expr [, expr]*] )
def p_expr_static_dispatch_params(p):
    'expr : expr AT TYPE DOT IDENTIFIER LPAREN exprs RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTStaticDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5], p.lineno(5), p[7])

# expr ::= expr[@TYPE].ID()
def p_expr_static_dispatch(p):
    'expr : expr AT TYPE DOT IDENTIFIER LPAREN RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTStaticDispatch(p.lineno(1), p[1], p[3], p.lineno(3), p[5], p.lineno(5), [])

# Self dispatch expression
# expr ::= ID( [expr [, expr]*] )
def p_expr_dispatch_params(p):
    'expr : IDENTIFIER LPAREN exprs RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTSelfDispatch(p.lineno(1), p[1], p.lineno(1), p[3])

# expr ::= ID( [expr [, expr]*] )
def p_expr_dispatch(p):
    'expr : IDENTIFIER LPAREN RPAREN'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTSelfDispatch(p.lineno(1), p[1], p.lineno(1), [])

# exprs ::= expr [, expr]*
def p_exprs(p):
    'exprs : expr COMMA exprs'
    p[0] = [p[1]] + p[3]

# exprs ::= expr
def p_exprs_base(p):
    'exprs : expr'
    p[0] = [p[1]]


# If-then-else expression
# expr ::= if expr then expr else expr fi
def p_expr_if(p):
    'expr : IF expr THEN expr ELSE expr FI'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTIf(p.lineno(1), p[2], p[4], p[6])

# While expression
# expr ::= while expr loop expr pool
def p_expr_while(p):
    'expr : WHILE expr LOOP expr POOL'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTWhile(p.lineno(1), p[2], p[4])

# Block expression
# expr ::= { [expr;]+ }
def p_block(p):
    'expr : LBRACE exprsemi RBRACE'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTBlock(p.lineno(1), p[2])

# exprsemi ::= [expr;]+
def p_exprsemi(p):
    'exprsemi : expr SEMI exprsemi'
    p[0] = [p[1]] + p[3]

# exprsemi ::= expr;
def p_exprsemi_base(p):
    'exprsemi : expr SEMI'
    p[0] = [p[1]]

# Let expression
# expr ::= let ID : TYPE [ <- expr ] [, ID : TYPE [<- expr]]* in expr
def p_expr_let(p):
    'expr : LET bindings IN expr'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTLet(p.lineno(1), p[2], p[4])

# bindings ::= ID : TYPE <- expr
def p_bindings_init(p):
    'bindings : IDENTIFIER COLON TYPE LARROW expr bindings_tail'
    p[0] = [ASTBinding('let_binding_init', p[1], p.lineno(1), p[3], p.lineno(3), p[5])] + p[6]

# bindings ::= ID : TYPE 
def p_bindings_no_init(p):
    'bindings : IDENTIFIER COLON TYPE bindings_tail'
    p[0] = [ASTBinding('let_binding_no_init', p[1], p.lineno(1), p[3], p.lineno(3), None)] + p[4]

# bindings ::= [, ID : TYPE <- expr]*
def p_bindings_tail_init(p):
    'bindings_tail : COMMA IDENTIFIER COLON TYPE LARROW expr bindings_tail'
    p[0] = [ASTBinding('let_binding_init', p[2], p.lineno(2), p[4], p.lineno(4), p[6])] + p[7] 

# bindings ::= [, ID : TYPE]*
def p_bindings_tail_no_init(p):
    'bindings_tail : COMMA IDENTIFIER COLON TYPE bindings_tail'
    p[0] = [ASTBinding('let_binding_no_init', p[2], p.lineno(2), p[4], p.lineno(4), None)] + p[5] 

def p_bindings_base(p):
    'bindings_tail : '
    p[0] = []

# Case expression
# expr ::= case expr of [ID : TYPE => expr;]+ esac
def p_expr_case(p):
    'expr : CASE expr OF cases ESAC'
    p.set_lineno(0, p.lineno(1))    
    p[0] = ASTCase(p.lineno(1), p[2], p[4])

# cases ::= [ID : TYPE => expr;]+
def p_cases(p):
    'cases : IDENTIFIER COLON TYPE RARROW expr SEMI cases'
    p[0] = [ASTCaseElement(p[1], p.lineno(1), p[3], p.lineno(3), p[5])] + p[7]

# cases ::= ID : TYPE => expr;
def p_cases_base(p):
    'cases : IDENTIFIER COLON TYPE RARROW expr SEMI'
    p[0] = [ASTCaseElement(p[1], p.lineno(1), p[3], p.lineno(3), p[5])]


# New expression
# expr ::= new TYPE
def p_expr_new(p):
    'expr : NEW TYPE'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTNew(p.lineno(1), p[2], p.lineno(2))

# Isvoid expression
# expr ::= isvoid expr
def p_expr_isvoid(p):
    'expr : ISVOID expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTIsVoid(p.lineno(1), p[2])

# Arithmetic expressions
# expr ::= expr + expr
def p_expr_plus(p):
    'expr : expr PLUS expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBinOp(p.lineno(1), 'plus', p[1], p[3])

# expr ::= expr - expr
def p_expr_minus(p):
    'expr : expr MINUS expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBinOp(p.lineno(1), 'minus', p[1], p[3])

# expr ::= expr * expr
def p_expr_times(p):
    'expr : expr TIMES expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBinOp(p.lineno(1), 'times', p[1], p[3])

# expr ::= expr / expr
def p_expr_divide(p):
    'expr : expr DIVIDE expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBinOp(p.lineno(1), 'divide', p[1], p[3])

# Comparison expressions
# expr ::= expr < expr
def p_expr_lt(p):
    'expr : expr LT expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBoolOp(p.lineno(1), 'lt', p[1], p[3])

# expr ::= expr <= expr
def p_expr_le(p):
    'expr : expr LE expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBoolOp(p.lineno(1), 'le', p[1], p[3])

# expr ::= expr = expr
def p_expr_equals(p):
    'expr : expr EQUALS expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBoolOp(p.lineno(1), 'eq', p[1], p[3])

# Not expression
# expr ::= not expr
def p_expr_not(p):
    'expr : NOT expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTNot(p.lineno(1), p[2])

# Negate expression
# expr ::= ~ expr
def p_expr_negate(p):
    'expr : TILDE expr'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTNegate(p.lineno(1), p[2])

# Parentheses expression
# expr ::= (expr)
def p_expr_parens(p):
    'expr : LPAREN expr RPAREN'
    p.set_lineno(0, p.lineno(1))
    p[2].line = p.lineno(1) # Handles line number falling through
    p[0] = p[2]

# Indentifier expression
# expr ::= ID
def p_expr_identifier(p):
    'expr : IDENTIFIER'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTIdentifier(p.lineno(1), p[1], p.lineno(1))

# Constant expressions
# expr ::= integer
def p_expr_integer(p):
    'expr : INTEGER'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTInteger(p.lineno(1), p[1])

# expr ::= string
def p_expr_string(p):
    'expr : STRING'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTString(p.lineno(1), p[1])

# expr ::= true
def p_expr_true(p):
    'expr : TRUE'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBoolean(p.lineno(1), 'true')

# expr ::= false
def p_expr_false(p):
    'expr : FALSE'
    p.set_lineno(0, p.lineno(1))
    p[0] = ASTBoolean(p.lineno(1), 'false')

# Error messages
def p_error(p):
    s = ""
    lineno = 1
    if p:
        lineno = p.lineno
        if p.value:
            s = str(p.value)
        elif str(p.type) in token_error_map:
            s = token_error_map[str(p.type)]
        else:
            s = str(p.type)
    print "ERROR: " + str(lineno) + ": Parser: syntax error near " + s
    sys.exit()   

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

# Writes to output file
def write_output(filename, ast):
    f = open(filename[:-4] + "-ast", 'w')
    f.write(str(ast))

# 
def main():
    filename = sys.argv[1]
    lexed = read_input(filename)
    token_tuples = get_tokens(lexed)

    lex = Lexer(token_tuples)
    parser = yacc.yacc()
    ast = yacc.parse(lexer=lex)
    write_output(filename, ast)

if __name__ == '__main__':
    main()