(* A.J. Varshneya (ajv4dg)
 * Spencer Gennari (sdg6vt)
 *)

open Printf 

type program = cool_class list 																(* program *)
and lineno = string 																		(* line number *)
and identifier = lineno * string 															(* identifier *)
and cool_type = identifier																	(* type *)
and cool_class = identifier * (identifier option) * feature list							(* class *)
and feature = 																				(* features *)
	| Attribute of identifier * cool_type * (expression option)								(* attribute *)
	| Method of identifier * formal list * cool_type * expression							(* method *)
and formal = identifier * cool_type															(* formal *)
and static_type = string 																	(* static type for expressions *)
and expression = lineno * expression_kind (* * static_type *) 								(* expression *)
and expression_kind = 																		(* kinds of expressions *)
	| Assign of identifier * expression 													(* assign \n var:identifier rhs:exp *)
	| DynamicDispatch of expression * identifier * expression list							(* dynamic_dispatch \n e:exp method:identifier args:exp-list *)
	| StaticDispatch of expression * identifier * identifier * expression list				(* static_dispatch \n e:exp type:identifier method:identifier args:exp-list *)
	| SelfDispatch of identifier * expression list											(* self_dispatch \n method:identifier args:exp-list *)
	| If of epxression * expression * expression											(* if \n predicate:exp then:exp else:exp *)
	| While of expression * expression														(* while \n predicate:exp body:exp *)
	| Block of expression list 																(* block \n body:exp-list *)
	| New of identifier																		(* new \n class:identifier *)
	| IsVoid of expression 																	(* isvoid \n e:exp *)
	| Plus of expression * expression														(* plus \n x:exp y:exp *)
	| Minus of expression * expression														(* minus \n x:exp y:exp *)
	| Times of expression * expression														(* times \n x:exp y:exp *)
	| Divide of expression * expression														(* divide \n x:exp y:exp *)
	| LessThan of expression * expression													(* lt \n x:exp y:exp *)
	| LessEqual of expression * expression													(* le \n x:exp y:exp *)
	| Equal of expression * expression														(* eq \n x:exp y:exp *)
	| Not of expression																		(* not \n x:exp *)
	| Negate of expression																	(* negate \n x:exp *)
	| Integer of string																		(* integer \n the_integer_constant \n *)
	| String of string																		(* string \n the_string_constant \n *)
	| Identifier of identifier																(* identifier \n variable:identifier *)
	| Boolean of string																		(* true \n OR false \n*)
	| Let of let_binding list																(* let \n binding-list *)
	| Case of expression * case_element list												(* case \n case_element-list *)
and let_binding = identifier * identifier * (expression  option) * expression				(* let_binding[_no]_init \n variable:identifier type:identifier [value:exp] *)
and case_element = identifier * identifier * expression										(* variable:identifier type:identifier body:exp *)

let main () = begin
	
	(* Get filename and open it *)
	let fname = Sys.argv.(1) in
	let fin = open_in fname in

	(* Range function like in Python *)
	let rec range k = 
		if k <= 0 then []
		else k :: (range (k - 1))
	in

	(* Read one line from file *)
	let read () = 
		input_line fin
	in

	(* Reads in a list *)
	let read_list worker = 
		let k = int_of_string (read ()) in 			(* Read number of elements *)
		let lst = range k in 						(* Get a range for that number *)
		List.map (fun _ -> worker ()) lst 			(* Apply worker k times *)
	in

	(* Procedures to read in AST *)
	let rec read_cool_program () =					(* program *)
		read_list read_cool_class

	and read_identifier () =						(* identifier *)
		let lineno = read () in
		let name = read () in
		(lineno, name)

	and read_cool_class () =						(* class *)
		let cname = read_identifier () in
		let inherits = match read () with 
			| "no_inherits" -> None
			| "inherits" ->
				let super = read_identifier () in
				Some(super)
			| _ -> failwith ("Invalid inherits field")
		in
		let features = read_list read_feature in 
		(cname, inherits, features)

	and read_feature () =
		match read () with
		| "attribute_no_init" -> 
			let fname = read_identifier () in 
			let ftype = read_identifier () in
			Attribute(fname, ftype, None)
		| "attribute_init" ->
			let fname = read_identifier () in 
			let ftype = read_identifier () in
			let finit = read_expression () in
			Attribute(fname, ftype, (Some finit))
		| "method" ->
			let mname = read_identifier () in
			let formals = read_list read_formal in
			let mtype = read_identifier () in
			let mbody = read_expression () in
			Method(mname, formals, mtype, mbody)
		| _ -> failwith ("Invalid feature kind")

	and read_formal () =
		let fname = read_identifier () in
		let ftype = read_identifier () in
		(fname, ftype)

	and read_expression () =
		let elineno = read () in
		let ekind = match read () with
		| "assign" ->												(* assign \n var:identifier rhs:exp *)
			let var = read_identifier () in
			let exp = read_expression () in
			Assign (var, exp)
		| "dynamic_dispatch" ->										(* dynamic_dispatch \n e:exp method:identifier args:exp-list *)
			let exp = read_expression () in
			let mname = read_identifier () in 
			let args = read_list read_expression in
			DynamicDispatch (exp, mname, args)
		| "static_dispatch" ->										(* static_dispatch \n e:exp type:identifier method:identifier args:exp-list *)
			let exp = read_expression () in
			let etype = read_identifier () in
			let mname = read_identifier () in 
			let args = read_list read_expression in
			StaticDispatch (exp, etype, mname, args)
		| "self_dispatch" ->										(* self_dispatch \n method:identifier args:exp-list *)
			let mname = read_identifier () in 
			let args = read_list read_expression in
			SelfDispatch (mname, args)
		| "if" ->													(* if \n predicate:exp then:exp else:exp *)
			let ipred = read_expression () in
			let ithen = read_expression () in
			let ielse = read_expression () in
			If (ipred, ithen, ielse)
		| "while" ->												(* while \n predicate:exp body:exp *)
			let epred = read_expression () in
			let ebody = read_expression () in
			While (epred, ebody)
		| "block" ->												(* block \n body:exp-list *)
			let exp_list = read_list read_expression in
			Block (exp_list) 
		| "new" ->													(* new \n class:identifier *)
			let cname = read_identifier () in
			New (cname)
		| "isvoid" ->												(* isvoid \n e:exp *)
			let exp = read_expression () in
			IsVoid (exp)
		| "plus" ->													(* plus \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			Plus (e1, e2)
		| "minus" ->												(* minus \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			Minus (e1, e2)
		| "times" ->												(* times \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			Times (e1, e2)
		| "divide" ->												(* divide \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			Divide (e1, e2)
		| "lt" ->													(* lt \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			LessThan (e1, e2)
		| "le" ->													(* le \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			LessEqual (e1, e2)
		| "eq" ->													(* eq \n x:exp y:exp *)
			let e1 = read_expression () in
			let e2 = read_expression () in
			Equal (e1, e2)
		| "not" ->													(* not \n x:exp *)
			let exp = read_expression () in
			Not (exp)
		| "negate" ->												(* negate \n x:exp *)
			let exp = read_expression () in
			Negate (exp)
		| "integer" ->												(* integer \n the_integer_constant \n *)
			let ival = read () in
			Integer (ival)
		| "string" ->												(* string \n the_string_constant \n *)
			let sval = read () in
			String (sval)
		| "identifier" ->											(* identifier \n variable:identifier *)
			let id = read_identifier() in
			Identifier (id)
		| "true" ->													(* true \n *)
			let bval = read () in
			Boolean (bval)
		| "false" ->												(* false \n *)
			let bval = read () in
			Boolean (bval)
		| "let" ->													(* let \n binding-list *)
			let binding_list = read_list read_let_binding in
			Let (binding_list)
		| "case" ->													(* case \n case_element-list *)
			let exp = read_expression () in
			let case_element_list = read_list read_case_element in
			Case (case_element_list)

		| x -> (* Handle other expressions *)
			failwith ("Expression not yet handled. " ^ x)
		in
			(elineno, ekind, estatic_type)
(* 		let estatic_type = read () in
			(elineno, ekind, estatic_type) *)

	and read_let_binding () =										(* let_binding[_no]_init \n variable:identifier type:identifier [value:exp] *)
		let init = match read () with 
		| "let_binding_no_init" ->
			let var = read_identifier () in
			let etype = read_identifier () in
			(var, etype, None)
		| "let_binding_init" ->
			let var = read_identifier () in
			let etype = read_identifier () in
			let exp = read_expression () in
			(var, etype, (Some exp))

	and read_case_element () =										(* variable:identifier type:identifier body:exp *)
		let var = read_identifier () in
		let etype = read_identifier () in
		let exp = read_expression () in
		(var, etype, exp)
	in

	let ast = read_cool_program () in
	close_in fin ;
	printf "CL-AST de-serialized, %d classes\n" (List.length ast) ;

end ;; 

main () ;;