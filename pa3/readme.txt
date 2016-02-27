README
CS 4501 - Compiler's Practicum
PA3 - The Parser
A.J. Varshneya (ajv4dg@virginia.edu)
Spencer Gennari (sdg6vt@virginia.edu)
2/23/16

This program is separated into four files: main.py, nodes.py, mylex.py, and yacc.py.

main.py
Contains file I/O, token generation logic, precedence/tokens definitions, parser error handling, and all grammar rules. The program's execution involves retrieving the lexed input, producing a lexer object from that input, and parsing the lexed tokens using yacc before writing it to an output file. We made our production rules by following the grammar provided in the Cool Reference Manual. While this was mostly straightforward, there are several tricker production rules of note. 

For lists of nonterminals, we used recursive structures to either print a base case (zero or one of the specified symbol) or recurse on itself. The 'let' expression was implemented with such a structure in addition to using several other strategies. To implement 'let', we made six rules: p_expr_let, p_bindings_init, p_bindings_no_init, p_bindings_tail_init, p_bindings_tail_no_init, and p_bindings_base. These rules each do as their name's suggest. The p_expr_let rule is the top level expression. We use the next two rules to guarantee that there is at least one binding in the expression and the last three rules to optionally allow for additional initialized or uninitialized bindings. Finally, we included a precedence rule for 'in' to eliminate shift/reduce conflicts in parsing. We chose to make it right associative and have the lowest precedence such that inner expressions are evaluated first, including other let statements. 

Another point of note is our use of the set_lineno() function in many of our production rules. This function allows us to meet the specifications for expression line numbers. Per the assignment specifications, the line number of expressions is the line number of the left-most terminal token. Hence, for production rule with 'expr' on the left-hand side, we write 'p.set_lineno(0, p.lineno(1))'. This ensures that the line number of the expression will evaluate to its eventual left-most terminal as they propagate up the tree. 

nodes.py
Contains class definitions for each of the abstract syntax tree nodes which we use to build an AST representation from our lexed input. During parsing, matching production rules return (in many cases) an associated AST node object built using the classes outlined in this file. Each class has an __init__() method and a __str__() method. When we print the final AST object as a string, we walk over the AST calling the __str__ methods of each node's attributes to build an output string according to the given specifications. 

mylex.py
This file has a token class and a lexer class. Per the PLY documentation, the token class has four attributes: lineno, type, value, and lexpos. The lexer meanwhile has a token() method which is required by the parser and returns the next token in the list as a Token object. This is accomplished by storing a list of tuples representing the tokens as an attribute in the lexer along with an iterator for it. 

yacc.py
This file is the parser generator component of the Python Lex-Yacc (PLY) tool.

Testing 
We tested our code by using the instructor-provided cool sample code in addition to our own novel test cases. 

good.cl
Tests a series of nested expressions to ensure that line numbers are properly set. Specifically, the test case covers nested let statements, blocks, case statements, and dispatches. These four expressions were chosen since normal cool programs (such as the Cool samples given) do not typically deeply nest these expressions. Thus, good.cl makes sure that the parser handles line numbers for obscure nested expressions correctly.

bad.cl
The bad test case emphasizes correctness of the precedence rules. We test all operators at least once with other rules of similar precedence surrounding each. We additionally ensure that the non-associative boolean operators will not be accepted by the parser if their precedence is not explicitly specified using parentheses. Finally, we include a second syntactic error on line 29 to ensure that when the parser rejects a program, it quits on the first error.
