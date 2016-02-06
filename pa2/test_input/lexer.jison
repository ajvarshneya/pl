/* lexical grammar */

%lex
%x string
%x ml-comment
%x ml-comment-star
%x sl-comment
%options flex
%%

\s+										{/* white space */}				/* White space */

\"((?:[^\\\n]|\\.)*?)\"					{return 'string';}				

"(*"									{this.begin("ml-comment");}		/* multi line comment */
<ml-comment>[*]							{this.begin("ml-comment-star");}
<ml-comment><<EOF>>						{return "EOF_IN_COMMENT";}
<ml-comment>[^*]*						{}
<ml-comment-star>[)]					{this.popState(); this.popState();}
<ml-comment-star>[^)]					{this.popState();}			

"--"									{this.begin("sl-comment");}		/* single line comment */
<sl-comment>[\n]						{this.popState();}
<sl-comment><<EOF>>						{return "EOF_IN_COMMENT";}
<sl-comment>.*							{}		

([iI][nN][hH][eE][rR][iI][tT][sS])		{return 'inherits';}			/* Keywords */
([iI][sS][vV][oO][iI][dD])				{return 'isvoid';}
([cC][lL][aA][sS][sS])					{return 'class';}
([wW][hH][iI][lL][eE])					{return 'while';}
([cC][aA][sS][eE])						{return 'case';}
([eE][lL][sS][eE])						{return 'else';}
([eE][sS][aA][cC])						{return 'esac';}
([lL][oO][oO][pP])						{return 'loop';}
([pP][oO][oO][lL])						{return 'pool';}
([tT][hH][eE][nN])						{return 'then';}
([lL][eE][tT])							{return 'let';}
([nN][eE][wW])							{return 'new';}
([nN][oO][tT])							{return 'not';}
([fF][iI])								{return 'fi';}
([iI][fF])								{return 'if';}
([iI][nN])								{return 'in';}
([oO][fF])								{return 'of';}
(t[rR][uU][eE])							{return 'true';}				/* Booleans */
(f[aA][lL][sS][eE])						{return 'false';}

"<-"									{return 'larrow';}				/* Multi char operators */
"<="									{return 'le';}
"=>"									{return 'rarrow';}

"@"										{return 'at';}					/* Single char operators */
":"										{return 'colon';}
","										{return 'comma';}
"/"										{return 'divide';}
"."										{return 'dot';}
"{"										{return 'lbrace';}
"("										{return 'lparen';}
"<"										{return 'lt';}
"-"										{return 'minus';}
"+"										{return 'plus';}
"="										{return 'equals';}
"}"										{return 'rbrace';}
")"										{return 'rparen';}
";"										{return 'semi';}
"~"										{return 'tilde';}
"*"										{return 'times';}

[0-9]+									{return 'integer';}				/* Integers */

([A-Z]+[a-zA-Z0-9_]*)					{return 'type';}				/* Types */

([a-z]+[a-zA-Z0-9_]*)					{return 'identifier';}			/* Identifiers */

<<EOF>>									{return 'EOF';}					/* EOF */

/lex

%start expressions
%%

expressions
	: exprs EOF
	;

exprs
	: exprs expr
	| expr
	;

expr
	: string 		{
						if($1.indexOf('\0') != -1)	{
							console.error("ERROR: " + @1.first_line + ": " + "Lexer: String contains ASCII 0.");
							process.exit(0);
						} else {
							console.log(@1.first_line);
					 		console.log('string');
							console.log($1.substring(1, $1.length-1));
						}
					}

	| comment		{}

	| integer		{
						if($1 < 2147483647) {
							console.log(@1.first_line);
							console.log('integer');
							console.log($1);
						} else {
							console.error("ERROR: " + @1.first_line + ": " + "Lexer: Integer out of bounds.");
							process.exit(0);
						}
					}

	| type			{console.log(@1.first_line);
					 console.log('type');
					 console.log($1);}

	| identifier	{console.log(@1.first_line);
					 console.log('identifier');
					 console.log($1);}

	| operator 
	| keyword 
	| boolean
	| error
	;

operator
	: larrow		{console.log(@1.first_line); console.log('larrow');}
	| le			{console.log(@1.first_line); console.log('le');}
	| rarrow		{console.log(@1.first_line); console.log('rarrow');}
	| at 			{console.log(@1.first_line); console.log('at');}
	| colon			{console.log(@1.first_line); console.log('colon');}
	| comma			{console.log(@1.first_line); console.log('comma');}
	| divide		{console.log(@1.first_line); console.log('divide');}
	| dot			{console.log(@1.first_line); console.log('dot');}
	| lbrace		{console.log(@1.first_line); console.log('lbrace');}
	| lparen		{console.log(@1.first_line); console.log('lparen');}
	| lt			{console.log(@1.first_line); console.log('lt');}
	| minus			{console.log(@1.first_line); console.log('minus');}
	| plus			{console.log(@1.first_line); console.log('plus');}
	| equals		{console.log(@1.first_line); console.log('equals');}
	| rbrace		{console.log(@1.first_line); console.log('rbrace');}
	| rparen		{console.log(@1.first_line); console.log('rparen');}
	| semi			{console.log(@1.first_line); console.log('semi');}
	| tilde			{console.log(@1.first_line); console.log('tilde');}
	| times			{console.log(@1.first_line); console.log('times');}
	;

keyword
	: inherits		{console.log(@1.first_line); console.log('inherits');}
	| isvoid		{console.log(@1.first_line); console.log('isvoid');}
	| class			{console.log(@1.first_line); console.log('class');}
	| while			{console.log(@1.first_line); console.log('while');}
	| case 			{console.log(@1.first_line); console.log('case');}
	| else			{console.log(@1.first_line); console.log('else');}
	| esac			{console.log(@1.first_line); console.log('esac');}
	| loop			{console.log(@1.first_line); console.log('loop');}
	| pool			{console.log(@1.first_line); console.log('pool');}
	| then			{console.log(@1.first_line); console.log('then');}
	| let			{console.log(@1.first_line); console.log('let');}
	| new			{console.log(@1.first_line); console.log('new');}
	| not			{console.log(@1.first_line); console.log('not');}
	| fi			{console.log(@1.first_line); console.log('fi');}
	| if			{console.log(@1.first_line); console.log('if');}
	| in			{console.log(@1.first_line); console.log('in');}
	| of			{console.log(@1.first_line); console.log('of');}
	;

boolean
	: true			{console.log(@1.first_line); console.log('true');}
	| false			{console.log(@1.first_line); console.log('false');}
	;

error
	: NEWLINE_IN_STRING		{console.error("ERROR: " + @1.first_line + ": " + "Lexer: newline in string.");}
	| NULL_IN_STRING		{console.error("ERROR: " + @1.first_line + ": " + "Lexer: null character in string.");}
	| EOF_IN_COMMENT		{console.error("ERROR: " + @1.first_line + ": " + "Lexer: EOF in comment.");}
	;

/*TODO*/
/* Test NULL error from string */