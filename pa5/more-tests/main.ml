(* A.J. Varshneya (ajv4dg)
 * Spencer Gennari (sdg6vt)
 *)

open Printf 

(* Type definitions *)

(* AST *)
type cool_ast = (cool_class list) 																		(* program *)
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
	| New of cool_type																					(* new \n class:identifier *)
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
	| Integer of int32																					(* integer \n the_integer_constant \n *)
	| String of string																					(* string \n the_string_constant \n *)
	| Identifier of cool_identifier																		(* identifier \n variable:identifier *)
	| Boolean of bool																					(* true \n OR false \n*)
	| Let of (cool_let_binding list) * cool_expression													(* let \n binding-list \n body-exp *)
	| Case of cool_expression * (cool_case_element list)												(* case \n case_exp \n case_element-list *)
	| Internal of string 																				(* 0 \n type \n internal \n Class.method \n *)
and cool_let_binding = cool_identifier * cool_identifier * (cool_expression option)						(* let_binding[_no]_init \n variable:identifier type:identifier [value:exp] *)
and cool_case_element = cool_identifier * cool_identifier * cool_expression								(* variable:identifier type:identifier body:exp *)

(* Class map *)
type cool_class_map = (cool_class_cm list) 																(* class map *)
and cool_class_cm = string * (cool_attribute_cm list) 													(* class, attribute list*)
and cool_attribute_cm = cool_identifier * cool_identifier * (cool_expression option)					(* attribute name, type name, rhs expression *)

(* Implementation map *)
type cool_imp_map = (cool_class_im list)																(* implementation map *)
and cool_class_im = string * (cool_method_im list)														(* class, method list *)
and cool_method_im = string * (string list) * string * cool_expression 									(* method name, formal list, inherited class, body expression *)

(* Parent map *)
type cool_parent_map = (cool_class_pm list) 															(* parent map *)
and cool_class_pm = string * string 																	(* child class, parent class *)

(* Store maps ints to values *)
type value = 											(* raw values *)
| Object of string * (attribute list)
| StringObject of string * string
| IntegerObject of string * int32
| BooleanObject of string * bool
| Void
and attribute = string * int 							(* identifier, store location *)


(* Global variables *)
module EnvMap = Map.Make(String) ;;
module StoreMap = Map.Make(struct type t = int let compare = compare end) ;;
let location_counter = ref 0 ;;
let stack_counter = ref 0 ;;

(* Main *)
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
	let read_list (worker) = 
		(* printf "called read_list\n" ; *)
		let input = read () in
		let k = int_of_string (input) in 			(* Read number of elements *)
		let lst = range k in 						(* Get a range for that number *)
		List.map (fun _ -> worker ()) lst 			(* Apply worker k times *)
	in


	(* AST deserialization *)
	let rec read_cool_ast () =						(* program *)
		(* printf "called read_cool_ast\n" ; *)
		read_list read_cool_class

	and read_cool_identifier () =					(* identifier *)
		(* printf "called read_cool_identifier\n" ; *)
		let lineno = read () in
		let name = read () in
		(lineno, name)

	and read_cool_class () =						(* class *)
		(* printf "called read_cool_class\n" ; *)
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

	and read_cool_feature () =						(* feature *)
		(* printf "called read_cool_feature\n" ; *)
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
			let mident = read_cool_identifier () in
			let formals = read_list read_cool_formal in
			let mtype = read_cool_identifier () in
			let mbody = read_cool_expression () in
			Method(mident, formals, mtype, mbody)
		| x -> failwith ("Invalid feature kind " ^ x)

	and read_cool_formal () =
		(* printf "called read_cool_formal\n" ; *)
		let fname = read_cool_identifier () in
		let ftype = read_cool_identifier () in
		(fname, ftype)

	and read_cool_expression () =
		(* printf "called read_cool_expression\n" ; *)
		let elineno = read () in
		let estatic_type = read () in
		let ekind = match read () with
		| "assign" ->													(* assign \n var:identifier rhs:exp *)
			let var = read_cool_identifier () in
			let exp = read_cool_expression () in
			Assign (var, exp)
		| "dynamic_dispatch" ->											(* dynamic_dispatch \n e:exp method:identifier args:exp-list *)
			let exp = read_cool_expression () in
			let mident = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			DynamicDispatch (exp, mident, args)
		| "static_dispatch" ->											(* static_dispatch \n e:exp type:identifier method:identifier args:exp-list *)
			let exp = read_cool_expression () in
			let etype = read_cool_identifier () in
			let mident = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			StaticDispatch (exp, etype, mident, args)
		| "self_dispatch" ->											(* self_dispatch \n method:identifier args:exp-list *)
			let mident = read_cool_identifier () in 
			let args = read_list read_cool_expression in
			SelfDispatch (mident, args)
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
			let ival = Int32.of_string (read ()) in
			Integer (ival)
		| "string" ->													(* string \n the_string_constant \n *)
			let sval = read () in
			String (sval)
		| "identifier" ->												(* identifier \n variable:identifier *)
			let id = read_cool_identifier() in
			Identifier (id)
		| "true" ->														(* true \n *)
			Boolean (true)
		| "false" ->													(* false \n *)
			Boolean (false)
		| "let" ->														(* let \n binding-list \n body expression *)
			let binding_list = read_list read_cool_let_binding in
			let body = read_cool_expression () in
			Let (binding_list, body)
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
			(* printf "called read_cool_let_binding_no_init\n" ; *)
			let var = read_cool_identifier () in
			let etype = read_cool_identifier () in
			(var, etype, None)
		| "let_binding_init" ->
			(* printf "called read_cool_let_binding_init\n" ; *)
			let var = read_cool_identifier () in
			let etype = read_cool_identifier () in
			let exp = read_cool_expression () in
			(var, etype, (Some exp))
		| x ->
			failwith ("Invalid binding type " ^ x)

	and read_cool_case_element () =											(* variable:identifier type:identifier body:exp *)
		(* printf "called read_cool_case_element\n" ; *)
		let var = read_cool_identifier () in
		let etype = read_cool_identifier () in
		let exp = read_cool_expression () in
		(var, etype, exp)
	in


	(* Class map deserialization *)
	let rec read_cool_class_map () = 
		let _ = read () in (* Skip class map tag *)
		read_list read_cool_class_cm

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

	and class_map_get (class_map, key) =
		let cmp_key entry = 
			let (cname, attributes) = entry in
			(cname = key)
		in

		let entry = List.find cmp_key class_map in
		let (cname, attributes) = entry in
		attributes
	in


	(* Implementation map deserialization *)
	let rec read_cool_imp_map () =
		let _ = read () in (* Skip implementation map tag *)
		read_list read_cool_class_im

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
		let fname = read() in
		(fname)

	and imp_map_get (imp_map, tname, fname) = 
		let cmp_class entry =
			let (cname, methods) = entry in
			(cname = tname)
		in

		let cmp_method entry =
			let (mname, mformals, mdefined_in, mbody) = entry in
			(mname = fname)
		in

		let entry = List.find cmp_class imp_map in
		let (cname, method_list) = entry in
		List.find cmp_method method_list
	in

	(* Parent map deserialization *)
	let rec read_cool_parent_map () = 
		let _ = read () in (* Skip parent map tag *)
		read_list read_cool_class_pm

	and read_cool_class_pm () =
		let cname = read () in 
		let pname = read () in
		(cname, pname)

 	and parent_map_get (parent_map, key) =
		let cmp_key entry = 
			let (cname, pname) = entry in 
			(cname = key)
		in
		let entry = List.find cmp_key parent_map in
		let (cname, pname) = entry in
		pname
	in


	(* Interpret *)
	let rec eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) =
		let (lineno, static_type, exp_kind) = exp in
 		match exp_kind with
		| Assign (var, rhs) -> eval_assign (class_map, imp_map, parent_map, self_object, store, env, var, rhs)
	 	| DynamicDispatch (receiver, mident, args) -> eval_dynamic_dispatch (class_map, imp_map, parent_map, self_object, store, env, receiver, mident, args, lineno)
		| StaticDispatch (receiver, stype, mident, args) -> eval_static_dispatch (class_map, imp_map, parent_map, self_object, store, env, receiver, stype, mident, args, lineno)
		| SelfDispatch (mident, args) -> eval_self_dispatch (class_map, imp_map, parent_map, self_object, store, env, mident, args, lineno)
		| If (pred_exp, then_exp, else_exp) -> eval_if (class_map, imp_map, parent_map, self_object, store, env, pred_exp, then_exp, else_exp)
		| While (pred_exp, body_exp) -> eval_while (class_map, imp_map, parent_map, self_object, store, env, pred_exp, body_exp)
		| Block (exp_list) -> eval_block (class_map, imp_map, parent_map, self_object, store, env, exp_list)
		| New (type_ident) -> eval_new (class_map, imp_map, parent_map, self_object, store, env, type_ident, lineno)
		| IsVoid (exp) -> eval_isvoid (class_map, imp_map, parent_map, self_object, store, env, exp)
		| Plus (e1, e2) -> eval_plus (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| Minus (e1, e2) -> eval_minus (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| Times (e1, e2) -> eval_times (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| Divide (e1, e2) -> eval_divide (class_map, imp_map, parent_map, self_object, store, env, e1, e2, lineno)
		| LessThan (e1, e2) -> eval_less_than (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| LessEqual (e1, e2) -> eval_less_equal (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| Equal (e1, e2) -> eval_equal (class_map, imp_map, parent_map, self_object, store, env, e1, e2)
		| Not (exp) -> eval_not (class_map, imp_map, parent_map, self_object, store, env, exp)
		| Negate (exp) -> eval_neg (class_map, imp_map, parent_map, self_object, store, env, exp)
		| Boolean (constant) -> eval_bool (class_map, imp_map, parent_map, self_object, store, env, constant)
		| Integer (constant) -> eval_integer (class_map, imp_map, parent_map, self_object, store, env, constant)
		| String (constant) -> eval_string (class_map, imp_map, parent_map, self_object, store, env, constant)
		| Identifier (id) -> eval_identifier (class_map, imp_map, parent_map, self_object, store, env, id)
		| Let (binding_list, body) -> eval_let (class_map, imp_map, parent_map, self_object, store, env, binding_list, body)
		| Case (case_exp, case_elements) -> eval_case (class_map, imp_map, parent_map, self_object, store, env, case_exp, case_elements)
		| Internal (class_method) -> eval_internal (class_map, imp_map, parent_map, self_object, store, env, class_method)

	and eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, exp_list) =
		match exp_list with
		| [] -> ([], store)
		| expression :: tl ->
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, expression) in
			let (value_list, store) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, tl) in
			(value :: value_list, store)

	and eval_assign (class_map, imp_map, parent_map, self_object, store, env, var, rhs) = 
		(* Evaluate rhs expression *)
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, rhs) in
		let (lineno, identifier) = var in 
		let loc = EnvMap.find identifier env in
		let store3 = StoreMap.add loc value store2 in
		(value, store3)

	and eval_dynamic_dispatch (class_map, imp_map, parent_map, self_object, store, env, receiver, mident, args, lineno) =
		stack_inc (lineno) ;

		(* Evaluate argument objects expressions *)
		let (value_list, store1) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, args) in

		(* Evaluate receiver object expression *)
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store1, env, receiver) in

		(match value with 
		| Void -> (
			printf "ERROR: %s: Exception: dispatch on void\n" lineno ;
			exit 0;
		)
		| _ -> ()) ;

		(* Extract receiver object type and attribute list *)
		let receiver_type = get_value_type (value) in
		let receiver_attributes = get_value_attributes (value) in

		(* Implementation map lookup *)
		let (lineno, mname) = mident in 
		let mmethod = imp_map_get (imp_map, receiver_type, mname) in
		let (mname, mformals, mdefined_in, mbody) = mmethod in

		(* Add locations for each formal *)
		let locations = List.fold_left (fun xs _ -> new_location () :: xs) [] mformals in

		(* Set new locations to values in store *)
		let param_initializers = List.combine value_list locations in
		let store3 = eval_dispatch_init_params (store2, param_initializers) in

		(* Extend attribute list with formal/location list, environment constructed from this list *)
		let env_initializer = List.combine mformals locations in
		let env_initializer = receiver_attributes @ env_initializer in

		(* Create new environment out of attribute and formal identifiers / locations *)
		let env2 = EnvMap.empty in
		let env2 = eval_dispatch_init_env (env2, env_initializer) in

		(* Evaluate method body with receiver object as self and new environment *)
		let (value1, store4) = eval_expression (class_map, imp_map, parent_map, value, store3, env2, mbody) in

		stack_dec () ;

		(value1, store4)

	and eval_static_dispatch (class_map, imp_map, parent_map, self_object, store, env, receiver, stype, mident, args, lineno) = 
		stack_inc (lineno) ;

		(* Evaluate argument objects expressions *)
		let (value_list, store1) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, args) in

		(* Evaluate receiver object expression *)
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store1, env, receiver) in

		(match value with 
		| Void -> (
			printf "ERROR: %s: Exception: static dispatch on void\n" lineno ;
			exit 0;
		)
		| _ -> ()) ;

		 (* Extract receiver attribute list, type_name from identifier *)
		let receiver_attributes = get_value_attributes (value) in
		let (lineno, type_name) = stype in 

		(* Implementation map lookup *)
		let (lineno, mname) = mident in 
		let mmethod = imp_map_get (imp_map, type_name, mname) in (* Use the static type ... *)
		let (mname, mformals, mdefined_in, mbody) = mmethod in

		(* Add locations for each formal *)
		let locations = List.fold_left (fun xs _ -> new_location () :: xs) [] mformals in

		(* Set new locations to values in store *)
		let param_initializers = List.combine value_list locations in
		let store3 = eval_dispatch_init_params (store2, param_initializers) in

		(* Extend attribute list with formal/location list, environment constructed from this list *)
		let env_initializer = List.combine mformals locations in
		let env_initializer = receiver_attributes @ env_initializer in

		(* Create new environment out of attribute and formal identifiers / locations *)
		let env2 = EnvMap.empty in
		let env2 = eval_dispatch_init_env (env2, env_initializer) in

		(* Evaluate method body with receiver object as self and new environment *)
		let (value1, store4) = eval_expression (class_map, imp_map, parent_map, value, store3, env2, mbody) in

		stack_dec ();

		(value1, store4)

	and eval_self_dispatch (class_map, imp_map, parent_map, self_object, store, env, mident, args, lineno) =
		stack_inc (lineno);

		(* Evaluate argument objects expressions *)
		let (value_list, store1) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, args) in

		(* Set value to be self object *)
		let (value, store2) = (self_object, store1) in

		 (* Extract receiver object type and attribute list *)
		let receiver_type = get_value_type (value) in
		let receiver_attributes = get_value_attributes (value) in

		(* Implementation map lookup *)
		let (lineno, mname) = mident in 
		let mmethod = imp_map_get (imp_map, receiver_type, mname) in
		let (mname, mformals, mdefined_in, mbody) = mmethod in

		(* Add locations for each formal *)
		let locations = List.fold_left (fun xs _ -> new_location () :: xs) [] mformals in

		(* Set new locations to values in store *)
		let param_initializers = List.combine value_list locations in
		let store3 = eval_dispatch_init_params (store2, param_initializers) in

		(* Extend attribute list with formal/location list, environment constructed from this list *)
		let env_initializer = List.combine mformals locations in
		let env_initializer = receiver_attributes @ env_initializer in

		(* Create new environment out of attribute and formal identifiers / locations *)
		let env2 = EnvMap.empty in
		let env2 = eval_dispatch_init_env (env2, env_initializer) in

		(* Evaluate method body with receiver object as self and new environment *)
		let (value1, store4) = eval_expression (class_map, imp_map, parent_map, value, store3, env2, mbody) in

		stack_dec ();

		(value1, store4)

	and eval_dispatch_init_params (store, param_initializers) = 
		match param_initializers with
		| [] -> store
		| hd :: tl ->
			let (value, loc) = hd in
			let store = StoreMap.add loc value store in 
			eval_dispatch_init_params (store, tl)

	and eval_dispatch_init_env (env, env_initializer) =
		match env_initializer with
		| [] -> env
		| hd :: tl ->
			let (ident, loc) = hd in 
			let env = EnvMap.add ident loc env in
			eval_dispatch_init_env (env, tl)

	and eval_if (class_map, imp_map, parent_map, self_object, store, env, pred_exp, then_exp, else_exp) =
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, pred_exp) in
		match value with
		| BooleanObject (type_name, raw_bool) ->
			if raw_bool = true then
				eval_expression (class_map, imp_map, parent_map, self_object, store2, env, then_exp)
			else
				eval_expression (class_map, imp_map, parent_map, self_object, store2, env, else_exp)
		| _ -> failwith ("Predicate does not evaluate to a boolean.")

	and eval_while (class_map, imp_map, parent_map, self_object, store, env, pred_exp, body_exp) =
		(* Evaluate the predicate expression *)
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, pred_exp) in

		match value with 
		| BooleanObject (type_name, raw_bool) ->
			if raw_bool = true then
				(* Evaluate body of loop *)
				let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, body_exp) in

				(* Evaluate while loop with new store *)
				eval_while (class_map, imp_map, parent_map, self_object, store3, env, pred_exp, body_exp)
			else
				(Void, store2)

		| _ -> failwith ("Predicate does not evaluate to a boolean.")

	and eval_block (class_map, imp_map, parent_map, self_object, store, env, exp_list) = 
		match exp_list with
		| [] -> failwith "Invalid block, parser should have eliminated this."
		| exp :: [] -> eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp)
		| exp :: tl ->
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
			eval_block (class_map, imp_map, parent_map, self_object, store, env, tl)

	and eval_new (class_map, imp_map, parent_map, self_object, store, env, type_ident, lineno) =
		stack_inc (lineno);

		let (lineno, type_name) = type_ident in
		let (value1, store3) = (
		match type_name with
		| "Int" -> (IntegerObject ("Int", Int32.of_int (0)), store)
		| "String" -> (StringObject ("String", ""), store)
		| "Bool" -> (BooleanObject ("Bool", false), store)
		| _ -> begin
			(* Get correct type (considering SELF_TYPE) *)
			let t0 = if (type_name = "SELF_TYPE") then get_value_type (self_object) else type_name in 

			(* Get attributes for that type *)
			let class_attributes = class_map_get (class_map, t0) in

			(* Add locations for each attribute *)
			let locations = List.fold_left (fun xs _ -> new_location () :: xs) [] class_attributes in

			(* Get object attributes / instantiate *)
			let attribute_identifiers = List.fold_left (fun xs x -> let (id, type_name, rhs) = x in id :: xs) [] class_attributes in
			let object_attributes = List.combine attribute_identifiers locations in
			let value1 = Object (t0, object_attributes) in

			(* Initialize new locations in store with default values *)
			let attribute_types = List.fold_left (fun xs x -> let (id, type_name, rhs) = x in type_name :: xs) [] class_attributes in
			let default_initializers = List.combine attribute_types locations in
			let store2 = eval_new_init_attrs (store, default_initializers) in

			(* Evaluate/assign initializer expressions *)
			let env2 = EnvMap.empty in
			let env2 = eval_new_init_env (env2, object_attributes) in (* Create new environment *)
			let attr_initializers = List.combine class_attributes locations in
			let (value2, store3) = eval_new_eval_attr_exprs (class_map, imp_map, parent_map, value1, store2, env2, attr_initializers) in
			(value1, store3)
		end) in
		stack_dec ();
		(value1, store3)


	(* Returns a new store with default values in each of the specified (attribute) locations *)
	and eval_new_init_attrs (store, object_initializers) =
		match object_initializers with 
		| [] -> store
		| hd :: tl ->
			let (type_name, loc) = hd in
			match type_name with 
			| "String" -> 
				let store = StoreMap.add loc (StringObject ("String", "")) store in
				eval_new_init_attrs (store, tl)
			| "Int" -> 
				let store = StoreMap.add loc (IntegerObject ("Int", Int32.of_int(0))) store in
				eval_new_init_attrs (store, tl)
			| "Bool" -> 
				let store = StoreMap.add loc (BooleanObject ("Bool", false)) store in
				eval_new_init_attrs (store, tl)
			| _ -> 
				let store = StoreMap.add loc Void store in
				eval_new_init_attrs (store, tl)

	(* Returns a new environment with the desired attributes added to it *)
	and eval_new_init_env (env, object_attributes) =
		match object_attributes with
		| [] -> env
		| hd :: tl ->
			let (id, loc) = hd in
			let env = EnvMap.add id loc env in
			eval_new_init_env (env, tl)

	(* Returns a new value / store that retains the side effects from evaluating the attribute initializer expressions *)
	and eval_new_eval_attr_exprs (class_map, imp_map, parent_map, self_object, store, env, attr_initializers) =
		match attr_initializers with
		| [] -> (self_object, store)
		| (class_attribute, location) :: tl ->
			let (var_name, type_name, rhs) = class_attribute in
			match rhs with 
			| Some (exp) ->
				(* Evaluate initializer expression*)
				let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in

				(* Update the store with new value *)
				let loc = EnvMap.find var_name env in
				let store3 = StoreMap.add loc value store2 in
				eval_new_eval_attr_exprs (class_map, imp_map, parent_map, self_object, store3, env, tl)

			| None ->
				eval_new_eval_attr_exprs (class_map, imp_map, parent_map, self_object, store, env, tl)

	and eval_isvoid (class_map, imp_map, parent_map, self_object, store, env, exp) =
		let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
		match value with 
		| Void -> (BooleanObject ("Bool", true), store)
		| _ -> (BooleanObject ("Bool", false), store)

	and eval_plus (class_map, imp_map, parent_map, self_object, store, env, e1, e2) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		(* Retrieve the int32 values and compute result *)
		match value1, value2 with
		| IntegerObject(_, int1), IntegerObject(_, int2) ->
			let result = Int32.add int1 int2 in
			(IntegerObject ("Int", result), store3)
		| x, y -> failwith ("Tried to add with two non-integer objects!")

	and eval_minus (class_map, imp_map, parent_map, self_object, store, env, e1, e2) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		(* Retrieve the int32 values and compute result *)
		match value1, value2 with
		| IntegerObject(_, int1), IntegerObject(_, int2) ->
			let result = Int32.sub int1 int2 in
			(IntegerObject ("Int", result), store3)
		| x, y -> failwith ("Tried to subtract with two non-integer objects!")

	and eval_times (class_map, imp_map, parent_map, self_object, store, env, e1, e2) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		(* Retrieve the int32 values and compute result *)
		match value1, value2 with
		| IntegerObject(_, int1), IntegerObject(_, int2) ->
			let result = Int32.mul int1 int2 in
			(IntegerObject ("Int", result), store3)
		| x, y -> failwith ("Tried to multiply with two non-integer objects!")

	and eval_divide (class_map, imp_map, parent_map, self_object, store, env, e1, e2, lineno) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		(* Retrieve the int32 values and compute result *)
		match value1, value2 with
		| IntegerObject(_, int1), IntegerObject(_, int2) -> 
		begin
			let denom = Int32.to_int int2 in
			(if denom = 0 then 
				(printf "ERROR: %s: Exception: division by zero\n" lineno;
				exit 0;)
			);

			let result = Int32.div int1 int2 in
			(IntegerObject ("Int", result), store3)
		end
		| x, y -> failwith ("Tried to divide with two non-integer objects!")

 	and eval_equal (class_map, imp_map, parent_map, self_object, store, env, e1, e2) = 
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		match value1, value2 with
		| IntegerObject (_, int1), IntegerObject (_, int2) ->
			(BooleanObject("Bool", int1 = int2), store3)
		| StringObject (_, string1), StringObject (_, string2) ->
			(BooleanObject("Bool", string1 = string2), store3)
		| BooleanObject (_, bool1), BooleanObject (_, bool2) ->
			(BooleanObject("Bool", bool1 = bool2), store3)
		| Void, Void -> 
			(BooleanObject("Bool", true), store3)
		| value1, value2 -> 
			(BooleanObject("Bool", value1 == value2), store3)

	and eval_less_than (class_map, imp_map, parent_map, self_object, store, env, e1, e2) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		match value1, value2 with
		| IntegerObject (_, int1), IntegerObject (_, int2) ->
			(BooleanObject("Bool", int1 < int2), store3)
		| StringObject (_, string1), StringObject (_, string2) ->
			(BooleanObject("Bool", string1 < string2), store3)
		| BooleanObject (_, bool1), BooleanObject (_, bool2) ->
			(BooleanObject("Bool", bool1 < bool2), store3)
		| Void, Void -> 
			(BooleanObject("Bool", false), store3)
		| value1, value2 -> 
			(BooleanObject("Bool", false), store3)

	and eval_less_equal (class_map, imp_map, parent_map, self_object, store, env, e1, e2) =
		(* Evaluate operand expressions *)
		let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
		let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

		match value1, value2 with
		| IntegerObject (_, int1), IntegerObject (_, int2) ->
			(BooleanObject("Bool", int1 <= int2), store3)
		| StringObject (_, string1), StringObject (_, string2) ->
			(BooleanObject("Bool", string1 <= string2), store3)
		| BooleanObject (_, bool1), BooleanObject (_, bool2) ->
			(BooleanObject("Bool", bool1 <= bool2), store3)
		| Void, Void -> 
			(BooleanObject("Bool", true), store3)
		| value1, value2 -> 
			(BooleanObject("Bool", value1 == value2), store3)

 	and eval_not (class_map, imp_map, parent_map, self_object, store, env, exp) = 
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
		match value with 
		| BooleanObject (_, raw_bool) ->
			let result = BooleanObject ("Bool", not raw_bool) in
			(result, store2)
		| _ -> failwith "Tried to negate a non-boolean object!" 

 	and eval_neg (class_map, imp_map, parent_map, self_object, store, env, exp) = 
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
		match value with 
		| IntegerObject (_, raw_int32) ->
			let result = IntegerObject ("Int", Int32.neg raw_int32) in
			(result, store2)
		| _ -> failwith "Tried to negate a non-boolean object!" 

 	and eval_integer (class_map, imp_map, parent_map, self_object, store, env, constant) = 
		let value = IntegerObject ("Int", constant) in
		(value, store)

  	and eval_string (class_map, imp_map, parent_map, self_object, store, env, constant) = 
		let value = StringObject ("String", constant) in
		(value, store)

	and eval_identifier (class_map, imp_map, parent_map, self_object, store, env, id) =
		let (lineno, var_name) = id in
		if var_name = "self" then
			(self_object, store)
		else
			let location = EnvMap.find var_name env in
			let value = StoreMap.find location store in
			(value, store)

	and eval_bool (class_map, imp_map, parent_map, self_object, store, env, constant) = 
		let value = BooleanObject ("Bool", constant) in
		(value, store)

 	and eval_let (class_map, imp_map, parent_map, self_object, store, env, binding_list, body) = 
 		match binding_list with
 		| [] -> (* No more bindings, evaluate body *)
 			eval_expression (class_map, imp_map, parent_map, self_object, store, env, body)
 		| hd :: tl ->
 			match hd with 
 			| (var_id, type_id, None) ->
 				let (lineno, type_name) = type_id in
 				let (lineno, var_name) = var_id in

 				 (* Get a default object to put in the location since there's no expression*)
 				let value = (
 					match type_name with
 					| "String" -> StringObject ("String", "")
 					| "Int" -> IntegerObject ("Int", Int32.of_int(0))
 					| "Bool" -> BooleanObject ("Bool", false)
 					| _ -> Void
 				) in

 				(* Create new location *)
 				let loc = new_location () in

 				(* Put default object in the store at that location *)
 				let store3 = StoreMap.add loc value store in

 				(* Extend environment with variable/location *)
 				let env' = EnvMap.add var_name loc env in

 				(* Evaluate next binding ... *)
 				eval_let (class_map, imp_map, parent_map, self_object, store3, env', tl, body)

 			| (var_id, type_id, Some(exp)) ->
 				let (lineno, var_name) = var_id in

 				(* Evaluate the initializer expression *)
 				let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in

  				(* Create new location *)
 				let loc = new_location () in

 				(* Put default object in the store at that location *)
 				let store3 = StoreMap.add loc value store2 in

 				(* Extend environment with variable/location *)
 				let env' = EnvMap.add var_name loc env in

 				(* Evaluate next binding ... *)
 				eval_let (class_map, imp_map, parent_map, self_object, store3, env', tl, body)

	and eval_case (class_map, imp_map, parent_map, self_object, store, env, case_exp, case_elements) = 
		(* Evaluate case expression *)
		let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, case_exp) in

		(match value with 
		| Void -> 
			let (lineno, static_type, exp_kind) = case_exp in (
				printf "ERROR: %s: Exception: case on void\n" lineno ;
				exit 0;
			)
		| _ -> ()) ;

		(* Extract type names from case elements / evaluated exp *)
		let exp_type = get_value_type (value) in
		let case_types = eval_case_get_types (case_elements) in

		(* Compute least upper bound *)
		let (lineno, _, _) = case_exp in
		let closest_ancestor = lub (parent_map, exp_type, case_types, lineno) in
		let case_element = eval_case_get_element (closest_ancestor, case_elements) in 
		
		let (var_id, type_id, element_body) = case_element in
		let (lineno, var_name) = var_id in

		(* Get new location *)
		let loc = new_location () in

		(* Extend store with value/loc *)
		let store3 = StoreMap.add loc value store2 in

		(* Extend environment with loc/var *)
		let env = EnvMap.add var_name loc env in

		(* Evaluate selected case body *)
		let (value, store4) = eval_expression (class_map, imp_map, parent_map, self_object, store3, env, element_body) in
		(value, store4)


	and eval_case_get_types (case_elements) =
		match case_elements with
		| [] -> []
		| hd :: tl ->
			let (var_id, type_id, body) = hd in
			let (lineno, type_name) = type_id in
			type_name :: eval_case_get_types (tl)

	and eval_case_get_element (case_type, case_elements) =
		match case_elements with
		| [] -> failwith "None of the case elements had the correct type."
		| hd :: tl ->
			let (var_id, type_id, body) = hd in
			let (lineno, type_name) = type_id in
			if type_name = case_type then
				hd
			else
				eval_case_get_element (case_type, tl)

	and lub (parent_map, exp_type, case_types, lineno) =
		if List.mem exp_type case_types then
			exp_type
		else (
			if exp_type = "Object" then (printf "ERROR: %s: Exception: case without matching branch\n" lineno; exit 0) ;
			let parent_type = parent_map_get (parent_map, exp_type) in
			lub (parent_map, parent_type, case_types, lineno)
		)

 	and eval_internal (class_map, imp_map, parent_map, self_object, store, env, class_method) =
		match class_method with
		| "Object.abort" -> internal_abort (self_object, store, env)
		| "Object.type_name" -> internal_typename (self_object, store, env)
		| "Object.copy" -> internal_copy (self_object, store, env)
		| "IO.out_string" -> internal_out_string (self_object, store, env)
		| "IO.out_int" -> internal_out_int (self_object, store, env)
		| "IO.in_string" -> internal_in_string (self_object, store, env)
		| "IO.in_int" -> internal_in_int (self_object, store, env)
		| "String.length" -> internal_length (self_object, store, env)
		| "String.concat" -> internal_concat (self_object, store, env)
		| "String.substr" -> internal_substr (self_object, store, env)
		| _ -> failwith "Undefined internal hasn't been implemented."

 	and internal_abort (self_object, store, env) =
 		printf "abort\n" ;
 		exit 0;

 	and internal_typename (self_object, store, env) = 
 		let type_name = get_value_type self_object in
 		(StringObject ("String", type_name), store)

	and internal_copy (self_object, store, env) = 
		match self_object with
		| Object (type_name, attribute_list) -> (
			let (new_attributes, store) = internal_copy_attributes (self_object, store, env, attribute_list) in
			(Object (type_name, new_attributes), store)
		)
		| StringObject (type_name, raw_string) -> (StringObject (type_name, raw_string), store)
		| IntegerObject (type_name, raw_int32) -> (IntegerObject (type_name, raw_int32), store)
		| BooleanObject (type_name, raw_bool) -> (BooleanObject (type_name, raw_bool), store)
		| Void -> failwith "Dispatch on void, should have been caught earlier."

	and internal_copy_attributes (self_object, store, env, attribute_list) =
		match attribute_list with
		| [] -> ([], store)
		| hd :: tl ->
			let (var_name, loc) = hd in
			(* Retrieve value of attribute *)
			let value = StoreMap.find loc store in

			(* Get new location *)
			let loc = new_location () in

			(* Update store with new loc/value *)
			let store2 = StoreMap.add loc value store in

			(* Tail recurse over all attributes *)
			let (attributes, store3) = internal_copy_attributes (self_object, store2, env, tl) in
			((var_name, loc) :: attributes, store3)

 	and internal_out_string (self_object, store, env) = 
		(* Retrieve value of 'x' identifier *)
		let location = EnvMap.find "x" env in
		let value = StoreMap.find location store in
		match value with
		| StringObject (_, raw_string) ->
			let string_to_print = Str.global_replace (Str.regexp "[\\]n") "\n" raw_string in
			let string_to_print = Str.global_replace (Str.regexp "[\\]t") "\t" string_to_print in
			printf "%s%!" string_to_print ;
			(self_object, store)
		| _ -> failwith "Invalid object passed to out_string."

 	and internal_out_int (self_object, store, env) = 
		(* Retrieve value of 'x' identifier *)
		let location = EnvMap.find "x" env in
		let value = StoreMap.find location store in
		match value with
		| IntegerObject (_, raw_int32) ->
			printf "%d%!" (Int32.to_int (raw_int32)) ;
			(self_object, store)
		| _ -> failwith "Invalid object passed to out_int."

	and internal_in_string (self_object, store, env) =
		let s = input_line stdin in
		if String.contains s (Char.chr 0) then
			(StringObject("String", ""), store)
		else
			(StringObject("String", s), store)

	and internal_in_int (self_object, store, env) = 
		let s = input_line stdin in
		let s = Str.global_replace (Str.regexp "^[ \n\t\r]+") "" s in
		let s = get_int_from_string (s, false) in
		let raw_int = 
			let is_integer = try ignore (int_of_string s); true with _ -> false in
			if is_integer then (
				if String.length s > 12 then 0
				else (let i = int_of_string (s) in
					if (i > 2147483647 or i < -2147483648) then 0 else i))
			else 0
		in
		let raw_int32 = Int32.of_int (raw_int) in
		(IntegerObject("Int", raw_int32), store)

	and get_int_from_string (s, b) = 
		match s, b with
		| "", _ -> ""
		| _, true ->
		begin
			let c = (String.make 1 s.[0]) in
			let is_integer = try ignore (int_of_string c); true with _ -> false in
			let s = Str.string_after s 1 in
			if is_integer then (String.concat "" [c; get_int_from_string (s, true)]) else ""
		end
		| _, false -> 
		begin
			let c = (String.make 1 s.[0]) in
			let is_integer = try ignore (int_of_string c); true with _ -> false in
			let s = Str.string_after s 1 in
			if is_integer then (
				String.concat "" [c; get_int_from_string(s, true)]
			) else (
				""
			)
		end

	and internal_length (self_object, store, env) = 
		match self_object with
		| StringObject (_, raw_string) ->
			(IntegerObject("Int", Int32.of_int (String.length raw_string)), store)
		| _ -> failwith "Tried to call length on non-string object!"

	and internal_concat (self_object, store, env) = 
		match self_object with
		| StringObject (_, raw_string1) -> begin
				let location = EnvMap.find "s" env in
				let value = StoreMap.find location store in
				match value with 
				| StringObject (_, raw_string2) ->
					(StringObject("String", String.concat "" [raw_string1; raw_string2]), store)
				| _ -> failwith "Tried to pass non-string object to concat!"
			end
		| _ -> failwith "Tried to call concat on non-string object!"

	and internal_substr (self_object, store, env) = 
		match self_object with
		| StringObject (_, raw_string) -> 
		begin
			let location = EnvMap.find "i" env in
			let value = StoreMap.find location store in
			match value with 
			| IntegerObject (_, start_int32) ->
			begin
				let start = Int32.to_int (start_int32) in
				let location = EnvMap.find "l" env in
				let value = StoreMap.find location store in 
				match value with
				| IntegerObject (_, length_int32) ->
				begin
					let s_check = Int32.to_int start_int32 in
					let l_check = Int32.to_int length_int32 in

					let out_of_range = 
						if s_check < 0 then true else
						if l_check < 0 then true else
						if (s_check + l_check) > (String.length raw_string) then true else false
					in

					if out_of_range then (
						printf "ERROR: 0: Exception: String.substr out of range\n";
						exit 0;
					) ;

					let length = Int32.to_int (length_int32) in
					(StringObject("String", String.sub raw_string start length), store)
				end
				| _ -> failwith "Tried to pass non-integer length to substr!"
			end
			| _ -> failwith "Tried to pass non-integer start to substr!"
		end
		| _ -> failwith "Tried to call substr on non-string object!"

	and get_value_type (value) = 
		match value with
		| Object (type_name, _)  -> type_name
		| StringObject (type_name, _) -> type_name
		| IntegerObject (type_name, _) -> type_name
		| BooleanObject (type_name, _) -> type_name
		| Void -> failwith "Case or dispatch on void!"

	and get_value_attributes (value) =
		match value with
		| Object (_, alist) -> alist
		| StringObject (_, _) -> []
		| IntegerObject (_, _) -> []
		| BooleanObject (_, _) -> []
		| Void -> [] (* Dispatch on void? *)

	and new_location () =
		location_counter := !location_counter + 1 ;
		!location_counter

	and stack_inc (lineno) =
		stack_counter := !stack_counter + 1 ;
		if !stack_counter >= 1001 then (
				printf "ERROR: %s: Exception: stack overflow\n" lineno ;
				exit 0;
		)

	and stack_dec () =
		stack_counter := !stack_counter - 1;
 	in

	(* Deserialization *)
	let class_map = read_cool_class_map () in
	let imp_map = read_cool_imp_map () in
	let parent_map = read_cool_parent_map () in
	let _ = read_cool_ast () in

	(* Evaluation *)
	let env = EnvMap.empty in
	let store = StoreMap.empty in
	let self_object = Object ("", []) in
	let main_object = ("0", "Main", New ("0", "Main")) in
 	let main_call = ("0", "Object", DynamicDispatch(main_object, ("0", "main"), [])) in

	eval_expression (class_map, imp_map, parent_map, self_object, store, env, main_call) ;

end ;; 

main () ;;