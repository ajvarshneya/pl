import nodes

# Deserializes the AST
def generate_ast(raw_ast):
	iterator = iter(raw_ast)
	return ast(iterator)

def ast(iterator):
	# classes-list
	num_classes = next(iterator)
	classes = []
	for i in 1 to num_classes:
		classes += ast_class(iterator)
	return AST(classes)

def ast_class(iterator):
        # name:identifier
        name_line = next(iterator)
        name = next(iterator)
        # inherits \n 
	    inherits = next(iterator)
	    if inherits == "inherits":
            # superclass:identifier
	        superclass_line = next(iterator)
	        superclass = next(iterator)
	       
	    num_features = next(iterator)
	    features = []
	    for i in 1 to num_features:
	    	features += ast_feature(iterator)
        


	    	

def ast_feature(raw_ast, iterator):
def ast_formal(raw_ast, iterator):
def ast_expression(raw_ast, iterator):
def ast_assign(raw_ast, iterator):
def ast_dynamicdispatch(raw_ast, iterator):
def ast_staticdispatch(raw_ast, iterator):
def ast_selfdispatch(raw_ast, iterator):
def ast_if(raw_ast, iterator):
def ast_while(raw_ast, iterator):
def ast_block(raw_ast, iterator):
def ast_binding(raw_ast, iterator):
def ast_let(raw_ast, iterator):
def ast_caseelement(raw_ast, iterator):
def ast_case(raw_ast, iterator):
def ast_new(raw_ast, iterator):
def ast_isvoid(raw_ast, iterator):
def ast_binop(raw_ast, iterator):
def ast_boolop(raw_ast, iterator):
def ast_not(raw_ast, iterator):
def ast_negate(raw_ast, iterator):
def ast_integer(raw_ast, iterator):
def ast_string(raw_ast, iterator):
def ast_boolean(raw_ast, iterator):
def ast_identifier(raw_ast, iterator):

	do_prog_ast:
   read in number of classes x
   for i in 1 to x
      do_class_ast(i)
do_class_ast
   read in line number, class name, inheritance, number of features y
   for i in 1 to y
      if feature_i is a method: do_method_ast(i)
      else do_inherits_ast(i)
do_method_ast
    read in line number, method name, number of parameters z
    for i in 1 to z
        do_parameter_ast(i)
    read in return type
    read in body: do_expr_ast(ast)
do_inherits_ast
do_expr_ast(ast):
    read in line number
    read in type of expression t
    # depending on the type of node, take appropriate steps....
    switch(t):
        case 'assign': 
            # assign takes an identifier and an expression as AST children nodes
            ident = do_ident_ast
            expr = do_expr_ast
        case 'if':
            # if has a condition, a then body, and an else body
            cond = do_expr_ast
            thenexpr = do_expr_ast
            elseexpr = do_expr_ast

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

def  main():
	filename = sys.argv[1]
	raw_ast = read_input(filename)
	ast = generate_ast(raw_ast)

if __name__ == '__main__':
	main()