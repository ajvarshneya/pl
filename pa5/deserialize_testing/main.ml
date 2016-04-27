(* A.J. Varshneya (ajv4dg)
 * Spencer Gennari (sdg6vt)
 *)

open Printf 

type cool_program = (cool_class list) 																	(* program *)
and lineno = string 																					(* line number *)
and cool_identifier = lineno * string 																	(* identifier *)
and cool_type = cool_identifier																			(* type *)
and cool_class = cool_identifier * (cool_identifier option) * (cool_feature list)						(* class *)
and cool_feature = 																						(* features *)
	| Attribute of cool_identifier * cool_type * (cool_expression option)								(* attribute *)
	| Method of cool_identifier * (cool_formal list) * cool_type * cool_expression						(* method *)
and cool_formal = cool_identifier * cool_type															(* formal *)
and cool_static_type = string 																			(* static type for expressions *)
and cool_expression = lineno * cool_static_type * cool_expression_kind 									(* expression *)
and cool_expression_kind = 																				(* kinds of expressions *)
	| Assign of cool_identifier * cool_expression 														(* assign \n var:identifier rhs:exp *)
	| DynamicDispatch of cool_expression * cool_identifier * (cool_expression list)						(* dynamic_dispatch \n e:exp method:dentifier args:exp-list *)
	| StaticDispatch of cool_expression * cool_identifier * cool_identifier * (cool_expression list)	(* static_dispatch \n e:exp type:identifier method:identifier args:exp-list *)
	| SelfDispatch of cool_identifier * (cool_expression list)											(* self_dispatch \n method:cool_identifier args:exp-list *)
	| If of cool_expression * cool_expression * cool_expression											(* if \n predicate:exp then:exp else:exp *)
	| While of cool_expression * cool_expression														(* while \n predicate:exp body:exp *)
	| Block of (cool_expression list) 																	(* block \n body:exp-list *)
	| New of cool_identifier																			(* new \n class:identifier *)
	| IsVoid of cool_expression 																		(* isvoid \n e:exp *)
	| Plus of cool_expression * cool_expression															(* plus \n x:exp y:exp *)
	| Minus of cool_expression * cool_expression														(* minus \n x:exp y:exp *)
	| Times of cool_expression * cool_expression														(* times \n x:exp y:exp *)
	| Divide of cool_expression * cool_expression														(* divide \n x:exp y:exp *)
	| LessThan of cool_expression * cool_expression														(* lt \n x:exp y:exp *)
	| LessEqual of cool_expression * cool_expression													(* le \n x:exp y:exp *)
	| Equal of cool_expression * cool_expression														(* eq \n x:exp y:exp *)
	| Not of cool_expression																			(* not \n x:exp *)
	| Negate of cool_expression																			(* negate \n x:exp *)
	| Integer of string																					(* integer \n the_integer_constant \n *)
	| String of string																					(* string \n the_string_constant \n *)
	| Identifier of cool_identifier																		(* identifier \n variable:identifier *)
	| Boolean of string																					(* true \n OR false \n*)
	| Let of (cool_let_binding list)																	(* let \n binding-list *)
	| Case of cool_expression * (cool_case_element list)												(* case \n case_element-list *)
	| Internal of string 																				(* *)
and cool_let_binding = cool_identifier * cool_identifier * (cool_expression option)						(* let_binding[_no]_init \n variable:identifier type:identifier [value:exp] *)
and cool_case_element = cool_identifier * cool_identifier * cool_expression								(* variable:identifier type:identifier body:exp *)

type cool_class_map = (cool_class_cm list) 																(* class map *)
and cool_class_cm = string * (cool_attribute_cm list) 													(* class map entry *)
and cool_attribute_cm = cool_identifier * cool_identifier * (cool_expression option)

type cool_imp_map = (cool_class_im list)
and cool_class_im = string * (cool_method_im list)
and cool_method_im = string * (string list) * string * cool_expression

type cool_parent_map = (cool_class_pm list)
and cool_class_pm = string * string

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
		let input = read () in
		let k = int_of_string (input) in 			(* Read number of elements *)
		let lst = range k in 						(* Get a range for that number *)
		List.map (fun _ -> worker ()) lst 			(* Apply worker k times *)
	in


	(* AST deserialization *)
	let rec read_cool_program () =					(* program *)
		read_list read_cool_class

	and read_cool_identifier () =						(* identifier *)
		let lineno = read () in
		let name = read () in
		(lineno, name)

	and read_cool_class () =						(* class *)
		let cname = read_cool_identifier () in
		let inherits = match read () with 
			| "no_inherits" -> None
			| "inherits" ->
				let super = read_cool_identifier () in
				Some(super)
			| x -> failwith ("Invalid inherits field " ^ x)
		in
		let features = read_list read_cool_feature in 
		(cname, inherits, features)

	and read_cool_feature () =							(* feature *)
		match read () with
		| "attribute_no_init" -> 
			let fname = read_cool_identifier () in 
			let ftype = read_cool_identifier () in
			Attribute(fname, ftype, None)
		| "attribute_init" ->
			let fname = read_cool_identifier () in 
			let ftype = read_cool_identifier () in
			let finit = read_cool_expression () in
			Attribute(fname, ftype, (Some finit))
		| "method" ->
			let mname = read_cool_identifier () in
			let formals = read_list read_cool_formal in
			let mtype = read_cool_identifier () in
			let mbody = read_cool_expression () in
			Method(mname, formals, mtype, mbody)
		| x -> failwith ("Invalid feature kind " ^ x)

	and read_cool_formal () =
		let fname = read_cool_identifier () in
		let ftype = read_cool_identifier () in
		(fname, ftype)

	and read_cool_expression () =
		let elineno = read () in
		let estatic_type = read () in
		let ekind = match read () with
		| "assign" ->													(* assign \n var:identifier rhs:exp *)
			let var = read_cool_identifier () in
			let exp = read_cool_expression () in
			Assign (var, exp)
		| "dynamic_dispatch" ->											(* dynamic_dispatch \n e:exp method:identifier args:exp-list *)
			let exp = read_cool_expression () in
			let mname = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			DynamicDispatch (exp, mname, args)
		| "static_dispatch" ->											(* static_dispatch \n e:exp type:identifier method:identifier args:exp-list *)
			let exp = read_cool_expression () in
			let etype = read_cool_identifier () in
			let mname = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			StaticDispatch (exp, etype, mname, args)
		| "self_dispatch" ->											(* self_dispatch \n method:identifier args:exp-list *)
			let mname = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			SelfDispatch (mname, args)
		| "if" ->														(* if \n predicate:exp then:exp else:exp *)
			let ipred = read_cool_expression () in
			let ithen = read_cool_expression () in
			let ielse = read_cool_expression () in
			If (ipred, ithen, ielse)
		| "while" ->													(* while \n predicate:exp body:exp *)
			let epred = read_cool_expression () in
			let ebody = read_cool_expression () in
			While (epred, ebody)
		| "block" ->													(* block \n body:exp-list *)
			let exp_list = read_list read_cool_expression in
			Block (exp_list) 
		| "new" ->														(* new \n class:identifier *)
			let cname = read_cool_identifier () in
			New (cname)
		| "isvoid" ->													(* isvoid \n e:exp *)
			let exp = read_cool_expression () in
			IsVoid (exp)
		| "plus" ->														(* plus \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			Plus (e1, e2)
		| "minus" ->													(* minus \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			Minus (e1, e2)
		| "times" ->													(* times \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			Times (e1, e2)
		| "divide" ->													(* divide \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			Divide (e1, e2)
		| "lt" ->														(* lt \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			LessThan (e1, e2)
		| "le" ->														(* le \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			LessEqual (e1, e2)
		| "eq" ->														(* eq \n x:exp y:exp *)
			let e1 = read_cool_expression () in
			let e2 = read_cool_expression () in
			Equal (e1, e2)
		| "not" ->														(* not \n x:exp *)
			let exp = read_cool_expression () in
			Not (exp)
		| "negate" ->													(* negate \n x:exp *)
			let exp = read_cool_expression () in
			Negate (exp)
		| "integer" ->													(* integer \n the_integer_constant \n *)
			let ival = read () in
			Integer (ival)
		| "string" ->													(* string \n the_string_constant \n *)
			let sval = read () in
			String (sval)
		| "identifier" ->												(* identifier \n variable:identifier *)
			let id = read_cool_identifier() in
			Identifier (id)
		| "true" ->														(* true \n *)
			let bval = read () in
			Boolean (bval)
		| "false" ->													(* false \n *)
			let bval = read () in
			Boolean (bval)
		| "let" ->														(* let \n binding-list *)
			let binding_list = read_list read_cool_let_binding in
			Let (binding_list)
		| "case" ->														(* case \n case_element-list *)
			let exp = read_cool_expression () in
			let case_element_list = read_list read_cool_case_element in
			Case (exp, case_element_list)
		| "internal" ->
			let class_and_method = read () in
			Internal (class_and_method)

		| x -> 	(* Handle other expressions *)
			failwith ("Expression not yet handled " ^ x)
		in
			(elineno, estatic_type, ekind)

	and read_cool_let_binding () = 					 						(* let_binding[_no]_init \n variable:identifier type:identifier [value:exp] *)
		match read () with
		| "let_binding_no_init" ->
			let var = read_cool_identifier () in
			let etype = read_cool_identifier () in
			(var, etype, None)
		| "let_binding_init" ->
			let var = read_cool_identifier () in
			let etype = read_cool_identifier () in
			let exp = read_cool_expression () in
			(var, etype, (Some exp))
		| x ->
			failwith ("Invalid binding type " ^ x)

	and read_cool_case_element () =											(* variable:identifier type:identifier body:exp *)
		let var = read_cool_identifier () in
		let etype = read_cool_identifier () in
		let exp = read_cool_expression () in
		(var, etype, exp)
	in


	(* Class map deserialization *)
	let rec read_cool_class_map () = 
		let _ = read () in (* Skip class map tag *)
		read_list read_cool_class_cm ;

	and read_cool_class_cm () =
		let cname = read () in
		let cattributes = read_list read_cool_attribute_cm in
		(cname, cattributes)

	and read_cool_attribute_cm () = 
		match read () with
		| "no_initializer" ->
			let aname = read () in
			let atype = read () in
			(aname, atype, None)
		| "initializer" ->
			let aname = read () in
			let atype = read () in
			let ainit = read_cool_expression () in
			(aname, atype, Some (ainit))
		| x -> 
			failwith ("Invalid attribute kind " ^ x)
	in


	(* Implementation map deserialization *)
	let rec read_cool_imp_map () =
		let _ = read () in (* Skip implementation map tag *)
		read_list read_cool_class_im ;

	and read_cool_class_im () = 
		let cname = read () in
		let cmethods = read_list read_cool_method_im in
		(cname, cmethods)

	and read_cool_method_im () =
		let mname = read () in
		let mformals = read_list read_cool_formal_im in
		let mdefined_in = read () in
		let mbody = read_cool_expression () in
		(mname, mformals, mdefined_in, mbody)

	and read_cool_formal_im () =
		read ()
	in


	(* Parent map deserialization *)
	let rec read_cool_parent_map () = 
		let _ = read () in (* Skip parent map tag *)
		read_list read_cool_class_pm ;

	and read_cool_class_pm () =
		let cname = read () in 
		let pname = read () in
		(cname, pname)
	in

	let class_map = read_cool_class_map () in
	(* printf "class map deserialized, %d classes \n" (List.length class_map) ; *)

	let imp_map = read_cool_imp_map () in
	(* printf "imp map deserialized, %d classes \n" (List.length imp_map) ;  *)

	let parent_map = read_cool_parent_map () in
	(* printf "parent map deserialized, %d classes \n" (List.length parent_map) ; *)

	let ast = read_cool_program () in
	close_in fin ;
	(* printf "CL-AST de-serialized, %d classes\n" (List.length ast) ; *)

	


end ;; 

main () ;;