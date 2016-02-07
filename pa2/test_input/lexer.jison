/* lexical grammar */

%{
	var nesting = 0;	
%}

%lex
%x ml-comment
%x ml-comment-star
%x sl-comment
%options flex
%%

\(\*									{this.begin("ml-comment"); nesting++;} 	/* open comment */
<ml-comment>\(\*						{nesting++;}							/* nested open comment */
<ml-comment>[*]+\)						{										/* dec nesting if some number of * is followed by a ) */
											nesting--;
											if (nesting == 0) 
											{
												this.popState();
											}
										}
<ml-comment><<EOF>>						{
											process.stdout.write("ERROR: " + yylloc.first_line + ": " + "Lexer: EOF in (* comment *)\n"); 
											process.exit(1);
										}
<ml-comment>\s+							{}
<ml-comment>.							{}


\-\-.*									{}

\"([^\\\n]|(\\.))*?\"					{return 'STRING';}				/* string */

([iI][nN][hH][eE][rR][iI][tT][sS])		{return 'INHERITS';}			/* Keywords */
([iI][sS][vV][oO][iI][dD])				{return 'ISVOID';}
([cC][lL][aA][sS][sS])					{return 'CLASS';}
([wW][hH][iI][lL][eE])					{return 'WHILE';}
([cC][aA][sS][eE])						{return 'CASE';}
([eE][lL][sS][eE])						{return 'ELSE';}
([eE][sS][aA][cC])						{return 'ESAC';}
([lL][oO][oO][pP])						{return 'LOOP';}
([pP][oO][oO][lL])						{return 'POOL';}
([tT][hH][eE][nN])						{return 'THEN';}
([lL][eE][tT])							{return 'LET';}
([nN][eE][wW])							{return 'NEW';}
([nN][oO][tT])							{return 'NOT';}
([fF][iI])								{return 'FI';}
([iI][fF])								{return 'IF';}
([iI][nN])								{return 'IN';}
([oO][fF])								{return 'OF';}
(t[rR][uU][eE])							{return 'TRUE';}				/* Booleans */
(f[aA][lL][sS][eE])						{return 'FALSE';}

"<-"									{return 'LARROW';}				/* Multi char operators */
"<="									{return 'LE';}
"=>"									{return 'RARROW';}

"@"										{return 'AT';}					/* Single char operators */
":"										{return 'COLON';}
","										{return 'COMMA';}
"/"										{return 'DIVIDE';}
"."										{return 'DOT';}
"{"										{return 'LBRACE';}
"("										{return 'LPAREN';}
"<"										{return 'LT';}
"-"										{return 'MINUS';}
"+"										{return 'PLUS';}
"="										{return 'EQUALS';}
"}"										{return 'RBRACE';}
")"										{return 'RPAREN';}
";"										{return 'SEMI';}
"~"										{return 'TILDE';}
"*"										{return 'TIMES';}

[0-9]+									{return 'INTEGER';}				/* Integers */

([A-Z]+[a-zA-Z0-9_]*)					{return 'TYPE';}				/* Types */

([a-z]+[a-zA-Z0-9_]*)					{return 'IDENTIFIER';}			/* Identifiers */

\s+										{/* white space */}

<<EOF>>									{return 'EOF';}					/* EOF */

.										{return 'ERROR_INVALID_CHAR'}

/lex

%start expressions
%%

expressions
	: exprs EOF
	| EOF
	;

exprs
	: exprs expr
	| expr
	;

expr
	: STRING 		{
						var hasNull = false;

						for (i = 0; i < yytext.length; i++) {
							if (yytext.charCodeAt(i) == 0) {
								hasNull = true;
							}
						}

						var length = yytext.length - 2;

						if (hasNull) {
							process.stdout.write("ERROR: " + @1.first_line + ": " + "Lexer: string cannot contain null character \n");
							process.exit(1);
						} else if (length <= 1024) {
							console.log(@1.first_line);
					 		console.log('string');
							console.log(yytext.substring(1, yytext.length - 1));
						} else {
							process.stdout.write("ERROR: " + @1.first_line + ": " + "Lexer: string constant is too long (" + length + " > 1024)\n");
							process.exit(1);
						}
					}

	| COMMENT		{}

	| INTEGER		{
						var num = parseInt(yytext);
						if(yytext <= 2147483647) {
							console.log(@1.first_line);
							console.log('integer');
							console.log(num);
						} else {
							process.stdout.write("ERROR: " + @1.first_line + ": " + "Lexer: not a non-negative 32-bit signed integer:" + num + "\n");
							process.exit(0);
						}
					}

	| TYPE			{console.log(@1.first_line);
					 console.log('type');
					 console.log(yytext);}

	| IDENTIFIER	{console.log(@1.first_line);
					 console.log('identifier');
					 console.log(yytext);}

	| OPERATOR 
	| KEYWORD
	| BOOLEAN
	| ERROR
	;

OPERATOR
	: LARROW		{console.log(@1.first_line); console.log('larrow');}
	| LE			{console.log(@1.first_line); console.log('le');}
	| RARROW		{console.log(@1.first_line); console.log('rarrow');}
	| AT 			{console.log(@1.first_line); console.log('at');}
	| COLON			{console.log(@1.first_line); console.log('colon');}
	| COMMA			{console.log(@1.first_line); console.log('comma');}
	| DIVIDE		{console.log(@1.first_line); console.log('divide');}
	| DOT			{console.log(@1.first_line); console.log('dot');}
	| LBRACE		{console.log(@1.first_line); console.log('lbrace');}
	| LPAREN		{console.log(@1.first_line); console.log('lparen');}
	| LT			{console.log(@1.first_line); console.log('lt');}
	| MINUS			{console.log(@1.first_line); console.log('minus');}
	| PLUS			{console.log(@1.first_line); console.log('plus');}
	| EQUALS		{console.log(@1.first_line); console.log('equals');}
	| RBRACE		{console.log(@1.first_line); console.log('rbrace');}
	| RPAREN		{console.log(@1.first_line); console.log('rparen');}
	| SEMI			{console.log(@1.first_line); console.log('semi');}
	| TILDE			{console.log(@1.first_line); console.log('tilde');}
	| TIMES			{console.log(@1.first_line); console.log('times');}
	;

KEYWORD
	: INHERITS		{console.log(@1.first_line); console.log('inherits');}
	| ISVOID		{console.log(@1.first_line); console.log('isvoid');}
	| CLASS			{console.log(@1.first_line); console.log('class');}
	| WHILE			{console.log(@1.first_line); console.log('while');}
	| CASE			{console.log(@1.first_line); console.log('case');}
	| ELSE			{console.log(@1.first_line); console.log('else');}
	| ESAC			{console.log(@1.first_line); console.log('esac');}
	| LOOP			{console.log(@1.first_line); console.log('loop');}
	| POOL			{console.log(@1.first_line); console.log('pool');}
	| THEN			{console.log(@1.first_line); console.log('then');}
	| LET			{console.log(@1.first_line); console.log('let');}
	| NEW			{console.log(@1.first_line); console.log('new');}
	| NOT			{console.log(@1.first_line); console.log('not');}
	| FI			{console.log(@1.first_line); console.log('fi');}
	| IF			{console.log(@1.first_line); console.log('if');}
	| IN			{console.log(@1.first_line); console.log('in');}
	| OF			{console.log(@1.first_line); console.log('of');}
	;

BOOLEAN
	: TRUE			{console.log(@1.first_line); console.log('true');}
	| FALSE			{console.log(@1.first_line); console.log('false');}
	;

ERROR
	: ERROR_INVALID_CHAR	{
								process.stdout.write("ERROR: " + @1.first_line + ": " + "Lexer: invalid character:" + yytext + "\n"); 
								process.exit(1);	
							}
	;



/*TODO*/
/* Test NULL error from string */