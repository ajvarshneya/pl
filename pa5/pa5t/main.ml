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
| Object of int * string * (attribute list)
| StringObject of int * string * string
| IntegerObject of int * string * int32
| BooleanObject of int * string * bool
| Void
and attribute = string * int 							(* identifier, store location *)


(* Global variables *)
module EnvMap = Map.Make(String) ;;
module StoreMap = Map.Make(struct type t = int let compare = compare end) ;;
let location_counter = ref 0 ;;

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
			let bval = bool_of_string (read ()) in
			Boolean (bval)
		| "false" ->													(* false \n *)
			let bval = bool_of_string (read ()) in
			Boolean (bval)
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

(* 	and parent_map_get (parent_map, key) =
		let cmp_key entry = 
			let (cname, pname) = entry in 
			(cname = key)
		in
		let entry = List.find cmp_key parent_map in
		let (cname, pname) = entry in
		pname *)
	in


	(* Interpret *)
	let rec eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) =
		let (lineno, static_type, exp_kind) = exp in
 		match exp_kind with
		| Assign (var, rhs) -> eval_assign (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
	 	| DynamicDispatch (receiver, mident, args) -> eval_dynamic_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| StaticDispatch (receiver, stype, mident, args) -> eval_static_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| SelfDispatch (mident, args) -> eval_self_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| If (pred_exp, then_exp, else_exp) -> eval_if (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| While (pred_exp, body_exp) -> eval_while (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Block (exp_list) -> eval_block (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| New (type_ident) -> eval_new (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| IsVoid (exp) -> eval_isvoid (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Plus (e1, e2) -> eval_plus (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Minus (e1, e2) -> eval_minus (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Times (e1, e2) -> eval_times (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Divide (e1, e2) -> eval_divide (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| LessThan (e1, e2) -> eval_less_than (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| LessEqual (e1, e2) -> eval_less_equal (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Equal (e1, e2) -> eval_equal (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Not (exp) -> eval_not (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Negate (exp) -> eval_neg (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Integer (constant) -> eval_integer (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| String (constant) -> eval_string (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Identifier (id) -> eval_identifier (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Boolean (constant) -> eval_bool (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| Let (let_bindings, body) -> failwith ("Expression not yet handled ")
		| Case (case_exp, case_elements) -> failwith ("Expression not yet handled ")
		| Internal (class_method) -> eval_internal (class_map, imp_map, parent_map, self_object, store, env, exp_kind)

	and eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, exp_list) =
		match exp_list with
		| [] -> ([], store)
		| expression :: tl ->
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, expression) in
			let (value_list, store) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, tl) in
			(value :: value_list, store)

	and eval_assign (class_map, imp_map, parent_map, self_object, store, env, exp_assign) = 
		match exp_assign with 
		| Assign (var, rhs) ->
			(* Evaluate rhs expression *)
			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, rhs) in
			let (lineno, identifier) = var in 
			let loc = EnvMap.find identifier env in
			let store3 = StoreMap.add loc value store2 in
			(value, store3)
		| _ -> failwith "Invalid type identifier passed to eval_assign."

	and eval_dynamic_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_dynamic_dispatch) =
		match exp_dynamic_dispatch with
		| DynamicDispatch (receiver, mident, args) ->

			(* Evaluate argument objects expressions *)
			let (value_list, store1) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, args) in

 			(* Evaluate receiver object expression *)
			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store1, env, receiver) in

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
 			(value1, store4)

		| _ -> failwith "Invalid expression passed to eval_dynamic_dispatch."

	and eval_static_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_static_dispatch) = 
		match exp_static_dispatch with
		| StaticDispatch (receiver, stype, mident, args) ->

			(* Evaluate argument objects expressions *)
			let (value_list, store1) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, args) in

 			(* Evaluate receiver object expression *)
			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store1, env, receiver) in

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
 			(value1, store4)

		| _ -> failwith "Invalid expression passed to eval_dynamic_dispatch."

	and eval_self_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_self_dispatch) =
		match exp_self_dispatch with
		| SelfDispatch (mident, args) ->

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
 			(value1, store4)

		| _ -> failwith "Invalid expression passed to eval_dynamic_dispatch."

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

	and eval_if (class_map, imp_map, parent_map, self_object, store, env, exp_if) =
		match exp_if with
 		| If (pred_exp, then_exp, else_exp) -> begin
	 			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, pred_exp) in
	 			match value with
	 			| BooleanObject (loc, type_name, raw_bool) ->
		 			if raw_bool = true then
		 				eval_expression (class_map, imp_map, parent_map, self_object, store2, env, then_exp)
		 			else
		 				eval_expression (class_map, imp_map, parent_map, self_object, store2, env, else_exp)
	  			| _ -> failwith ("Predicate does not evaluate to a boolean.")
			end
		| _ -> failwith "Invalid expression passed to eval_if."

	and eval_while (class_map, imp_map, parent_map, self_object, store, env, exp_while) =
		match exp_while with
		| While (pred_exp, body_exp) -> begin
				let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, pred_exp) in
				match value with 
				| BooleanObject (loc, type_name, raw_bool) ->
					if raw_bool = true then
						let (value2, store3) = 
						eval_expression (class_map, imp_map, parent_map, self_object, store, env, body_exp) in
						eval_while (class_map, imp_map, parent_map, self_object, store3, env, exp_while)
					else
						(Void, store2)
	  			| _ -> failwith ("Predicate does not evaluate to a boolean.")
			end
		| _ -> failwith "Invalid expression passed to eval_while."

	and eval_block (class_map, imp_map, parent_map, self_object, store, env, exp_block) = 
		match exp_block with
		| Block (exp_list) -> eval_block_exp_list (class_map, imp_map, parent_map, self_object, store, env, exp_list)
		| _ -> failwith "Invalid expression passed to eval_while."

	and eval_block_exp_list (class_map, imp_map, parent_map, self_object, store, env, exp_list) =
		match exp_list with
		| [] -> failwith "Invalid block, parser should have eliminated this."
		| exp :: [] -> eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp)
		| exp :: tl ->
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
			eval_block_exp_list (class_map, imp_map, parent_map, self_object, store, env, tl)

	and eval_new (class_map, imp_map, parent_map, self_object, store, env, exp_new) =
 		match exp_new with 
 		| New (type_ident) ->
	 		let (lineno, type_name) = type_ident in

	 		(* Get correct type (considering SELF_TYPE) *)
			let t0 = if (type_name = "SELF_TYPE") then get_value_type (self_object) else type_name in 
			
			(* Get attributes for that type *)
			let class_attributes = class_map_get (class_map, t0) in

			(* Add locations for each attribute *)
			let locations = List.fold_left (fun xs _ -> new_location () :: xs) [] class_attributes in

			(* Get object attributes / instantiate *)
			let attribute_identifiers = List.fold_left (fun xs x -> let (id, type_name, rhs) = x in id :: xs) [] class_attributes in
			let object_attributes = List.combine attribute_identifiers locations in
			let value1 = Object (-1, t0, object_attributes) in

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

		| _ -> failwith "Invalid expression passed to eval_new."

	(* Returns a new store with default values in each of the specified (attribute) locations *)
	and eval_new_init_attrs (store, object_initializers) =
		match object_initializers with 
		| [] -> store
		| hd :: tl ->
			let (type_name, loc) = hd in
 			match type_name with 
			| "String" -> 
				let store = StoreMap.add loc (StringObject (loc, "String", "")) store in
				eval_new_init_attrs (store, tl)
			| "Integer" -> 
				let store = StoreMap.add loc (IntegerObject (loc, "Int", Int32.of_int(0))) store in
				eval_new_init_attrs (store, tl)
			| "Bool" -> 
				let store = StoreMap.add loc (BooleanObject (loc, "Bool", false)) store in
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
			let (id, type_name, rhs) = class_attribute in
			match rhs with 
			| Some (exp) ->
				let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
				eval_new_eval_attr_exprs (class_map, imp_map, parent_map, self_object, store, env, tl)
			| None ->
				eval_new_eval_attr_exprs (class_map, imp_map, parent_map, self_object, store, env, tl)

	and eval_isvoid (class_map, imp_map, parent_map, self_object, store, env, exp_isvoid) =
		match exp_isvoid with
		| IsVoid (exp) -> begin
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
			match value with 
			| Void -> (BooleanObject (-1, "Bool", true), store)
			| _ -> (BooleanObject (-1, "Bool", false), store)
		end
		| _ -> failwith "Invalid expression passed to eval_isvoid."

	and eval_plus (class_map, imp_map, parent_map, self_object, store, env, exp_plus) =
		match exp_plus with
		| Plus (e1, e2) ->
			(* Evaluate operand expressions *)
			let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
			let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e1) in

			(* Retrieve the int32 values and compute result *)
			let int1 = eval_unbox_int value1 in
			let int2 = eval_unbox_int value2 in
			let int_result = Int32.add int1 int2 in

			(* Rebox and return *)
			let value = IntegerObject (-1, "Int", int_result) in
			(value, store3)

		| _ -> failwith "Invalid expression passed to eval_plus."

	and eval_minus (class_map, imp_map, parent_map, self_object, store, env, exp_minus) =
		match exp_minus with
		| Minus (e1, e2) ->
			(* Evaluate operand expressions *)
			let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
			let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e1) in

			(* Retrieve the int32 values and compute result *)
			let int1 = eval_unbox_int value1 in
			let int2 = eval_unbox_int value2 in
			let int_result = Int32.sub int1 int2 in

			(* Rebox and return *)
			let value = IntegerObject (-1, "Int", int_result) in
			(value, store3)

		| _ -> failwith "Invalid expression passed to eval_minus."

	and eval_times (class_map, imp_map, parent_map, self_object, store, env, exp_times) =
		match exp_times with
		| Minus (e1, e2) ->
			(* Evaluate operand expressions *)
			let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
			let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e1) in

			(* Retrieve the int32 values and compute result *)
			let int1 = eval_unbox_int value1 in
			let int2 = eval_unbox_int value2 in
			let int_result = Int32.mul int1 int2 in

			(* Rebox and return *)
			let value = IntegerObject (-1, "Int", int_result) in
			(value, store3)

		| _ -> failwith "Invalid expression passed to eval_times."

	and eval_divide (class_map, imp_map, parent_map, self_object, store, env, exp_divide) =
		match exp_divide with
		| Plus (e1, e2) ->
			(* Evaluate operand expressions *)
			let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
			let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e1) in

			(* Retrieve the int32 values and compute result *)
			let int1 = eval_unbox_int (value1) in
			let int2 = eval_unbox_int (value2) in
			let int_result = Int32.div int1 int2 in

			(* Rebox and return *)
			let value = IntegerObject (-1, "Int", int_result) in
			(value, store3)

		| _ -> failwith "Invalid expression passed to eval_divide."

 	and eval_equal (class_map, imp_map, parent_map, self_object, store, env, exp_equal) = 
		match exp_equal with
		| Equal (e1, e2) -> begin
				(* Evaluate oeprand expressions *)
				let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
				let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

				(* Unbox the values, typechecking makes it so we only have to check one for the type *)
				match value1 with
				| IntegerObject (_, _, int1) ->
					let int2 = eval_unbox_int (value2) in
					let result = BooleanObject(-1, "Bool", int1 = int2) in
					(result, store3)
				| StringObject (_, _, string1) ->
					let string2 = eval_unbox_string (value2) in
					let result = BooleanObject(-1, "Bool", string1 = string2) in
					(result, store3)
				| BooleanObject (_, _, bool1) ->
					let bool2 = eval_unbox_bool (value2) in
					let result = BooleanObject(-1, "Bool", bool1 = bool2) in
					(result, store3)
				| Object (loc1, _, _) ->
					let loc2 = get_value_location (value2) in 
					let result = BooleanObject(-1, "Bool", loc1 = loc2) in
					(result, store3)
				| Void -> 
					let loc2 = get_value_location (value2) in
					let result = BooleanObject(-1, "Bool", 0 = loc2) in
					(result, store3)
			end

 		| _ -> failwith "Invalid expression passed to eval_less_than."

  	and eval_less_than (class_map, imp_map, parent_map, self_object, store, env, exp_less_than) = 
		match exp_less_than with
		| LessThan (e1, e2) -> begin
				(* Evaluate oeprand expressions *)
				let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
				let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

				(* Unbox the values, typechecking makes it so we only have to check one for the type *)
				match value1 with
				| IntegerObject (_, _, int1) ->
					let int2 = eval_unbox_int (value2) in
					let result = BooleanObject(-1, "Bool", int1 < int2) in
					(result, store3)
				| StringObject (_, _, string1) ->
					let string2 = eval_unbox_string (value2) in
					let result = BooleanObject(-1, "Bool", string1 < string2) in
					(result, store3)
				| BooleanObject (_, _, bool1) ->
					let bool2 = eval_unbox_bool (value2) in
					let result = BooleanObject(-1, "Bool", bool1 < bool2) in
					(result, store3)
				| Object (_, _, _) ->
					let result = BooleanObject(-1, "Bool", false) in
					(result, store3)
				| Void -> 
					let result = BooleanObject(-1, "Bool", false) in
					(result, store3)
			end
 		| _ -> failwith "Invalid expression passed to eval_less_than."

  	and eval_less_equal (class_map, imp_map, parent_map, self_object, store, env, exp_less_equal) = 
		match exp_less_equal with
		| LessEqual (e1, e2) -> begin
				(* Evaluate oeprand expressions *)
				let (value1, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, e1) in
				let (value2, store3) = eval_expression (class_map, imp_map, parent_map, self_object, store2, env, e2) in

				(* Unbox the values, typechecking makes it so we only have to check one for the type *)
				match value1 with
				| IntegerObject (_, _, int1) ->
					let int2 = eval_unbox_int (value2) in
					let result = BooleanObject(-1, "Bool", int1 <= int2) in
					(result, store3)
				| StringObject (_, _, string1) ->
					let string2 = eval_unbox_string (value2) in
					let result = BooleanObject(-1, "Bool", string1 <= string2) in
					(result, store3)
				| BooleanObject (_, _, bool1) ->
					let bool2 = eval_unbox_bool (value2) in
					let result = BooleanObject(-1, "Bool", bool1 <= bool2) in
					(result, store3)
				| Object (loc1, _, _) ->
					let loc2 = get_value_location (value2) in 
					let result = BooleanObject(-1, "Bool", loc1 = loc2) in
					(result, store3)
				| Void -> 
					let loc2 = get_value_location (value2) in
					let result = BooleanObject(-1, "Bool", 0 = loc2) in
					(result, store3)
			end
 		| _ -> failwith "Invalid expression passed to eval_less_than."

 	and eval_not (class_map, imp_map, parent_map, self_object, store, env, exp_not) = 
 		match exp_not with
 		| Not (exp) -> begin
	 			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
	 			match value with 
	 			| BooleanObject (_, _, raw_bool) ->
	 				let result = BooleanObject (-1, "Bool", not raw_bool) in
	 				(result, store2)
	 			| _ -> failwith "Tried to negate a non-boolean object!" 
 			end
 		| _ -> failwith "Invalid expression passed to eval_not."

 	and eval_neg (class_map, imp_map, parent_map, self_object, store, env, exp_neg) = 
 		match exp_neg with
 		| Negate (exp) -> begin
	 			let (value, store2) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) in
	 			match value with 
	 			| IntegerObject (_, _, raw_int32) ->
	 				let result = IntegerObject (-1, "Int", Int32.neg raw_int32) in
	 				(result, store2)
	 			| _ -> failwith "Tried to negate a non-boolean object!" 
 			end
 		| _ -> failwith "Invalid expression passed to eval_neg."

 	and eval_integer (class_map, imp_map, parent_map, self_object, store, env, exp_integer) = 
 		match exp_integer with
 		| Integer (raw_int32) -> 
 			let value = IntegerObject (-1, "Int", raw_int32) in
 			(value, store)
 		| _ -> failwith "Invalid expression passed to eval_integer."

  	and eval_string (class_map, imp_map, parent_map, self_object, store, env, exp_string) = 
 		match exp_string with
 		| String (raw_string) -> 
 			let value = StringObject (-1, "String", raw_string) in
 			(value, store)
 		| _ -> failwith "Invalid expression passed to eval_string."

 	and eval_identifier (class_map, imp_map, parent_map, self_object, store, env, exp_identifier) =
 		match exp_identifier with 
 		| Identifier (id) ->
 			let (lineno, var_name) = id in
 			if var_name = "self" then
 				(self_object, store)
 			else
	 			let location = EnvMap.find var_name env in
	 			let value = StoreMap.find location store in
	 			(value, store)
 		| _ -> failwith "Invalid expression passed to eval_identifier"

 	and eval_bool (class_map, imp_map, parent_map, self_object, store, env, exp_bool) = 
 		match exp_bool with
 		| Boolean (raw_bool) -> 
 			let value = BooleanObject (-1, "Bool", raw_bool) in
 			(value, store)
 		| _ -> failwith "Invalid expression passed to eval_bool."

 	and eval_internal (class_map, imp_map, parent_map, self_object, store, env, exp_internal) =
 		match exp_internal with 
 		| Internal (class_method) -> begin
 				match class_method with
				| "Object.abort" -> internal_abort (self_object, store, env)
				| "Object.type_name" -> internal_typename (self_object, store, env)
				| "Object.copy" -> failwith "Object.copy hasn't been implemented."
				| "IO.out_string" -> internal_out_string (self_object, store, env)
				| "IO.out_int" -> internal_out_int (self_object, store, env)
				| "IO.in_string" -> internal_in_string (self_object, store, env)
				| "IO.in_int" -> internal_in_int (self_object, store, env)
				| "String.length" -> internal_length (self_object, store, env)
				| "String.concat" -> internal_concat (self_object, store, env)
				| "String.substr" -> internal_substr (self_object, store, env)
				| _ -> failwith "Undefined internal hasn't been implemented."
 			end
 		| _ -> failwith "Invalid expression passed to eval_internal."

 	and internal_abort (self_object, store, env) =
 		printf "abort\n" ;
 		exit 0;

 	and internal_typename (self_object, store, env) = 
 		let type_name = get_value_type self_object in
 		(StringObject (-1, "String", type_name), store)

(*  	and internal_copy ()
 *)
 	and internal_out_string (self_object, store, env) = 
		(* Retrieve value of 'x' identifier *)
		let location = EnvMap.find "x" env in
		let value = StoreMap.find location store in
		match value with
		| StringObject (_, _, raw_string) ->
			let string_to_print = Str.global_replace (Str.regexp "[\\]n") "\n" raw_string in
			let string_to_print = Str.global_replace (Str.regexp "[\\]t") "\t" string_to_print in
			let string_to_print = Str.global_replace (Str.regexp "[\\]r") "\r" string_to_print in
			printf "%s" string_to_print ;
			(self_object, store)
		| _ -> failwith "Invalid object passed to out_string."

 	and internal_out_int (self_object, store, env) = 
		(* Retrieve value of 'x' identifier *)
		let location = EnvMap.find "x" env in
		let value = StoreMap.find location store in
		match value with
		| IntegerObject (_, _, raw_int32) ->
			printf "%d" (Int32.to_int (raw_int32)) ;
			(self_object, store)
		| _ -> failwith "Invalid object passed to out_int."

	and internal_in_string (self_object, store, env) =
		let s = (Scanf.scanf "%s" (fun x -> x)) in
		(StringObject(-1, "String", s), store)

	and internal_in_int (self_object, store, env) = 
		let i = Int32.of_int (Scanf.scanf "%d" (fun x -> x)) in
		(IntegerObject(-1, "Int", i), store)

	and internal_length (self_object, store, env) = 
		match self_object with
		| StringObject (_, _, raw_string) ->
			(IntegerObject(-1, "Int", Int32.of_int (String.length raw_string)), store)
		| _ -> failwith "Tried to call length on non-string object!"

	and internal_concat (self_object, store, env) = 
		match self_object with
		| StringObject (_, _, raw_string1) -> begin
				let location = EnvMap.find "s" env in
				let value = StoreMap.find location store in
				match value with 
				| StringObject (_, _, raw_string2) ->
					(StringObject(-1, "String", String.concat "" [raw_string1; raw_string2]), store)
				| _ -> failwith "Tried to pass non-string object to concat!"
			end
		| _ -> failwith "Tried to call concat on non-string object!"

	and internal_substr (self_object, store, env) = 
		match self_object with
		| StringObject (_, _, raw_string) -> 
		begin
			let location = EnvMap.find "i" env in
			let value = StoreMap.find location store in
			match value with 
			| IntegerObject (_, _, start_int32) ->
			begin
				let start = Int32.to_int (start_int32) in
				let location = EnvMap.find "l" env in
				let value = StoreMap.find location store in 
				match value with
				| IntegerObject (_, _, length_int32) ->
					let length = Int32.to_int (length_int32) in
					(StringObject(-1, "String", String.sub raw_string start length), store)
				| _ -> failwith "Tried to pass non-integer length to substr!"
			end
			| _ -> failwith "Tried to pass non-integer start to substr!"
		end
		| _ -> failwith "Tried to call substr on non-string object!"

	and eval_unbox_int (value) =
		match value with 
		| IntegerObject (_, _, raw_int32) -> raw_int32
		| _ -> failwith "Tried to unbox a non-integer object!"

	and eval_unbox_string (value) =
		match value with 
		| StringObject (_, _, raw_string) -> raw_string
		| _ -> failwith "Tried to unbox a non-string object!"

	and eval_unbox_bool (value) =
		match value with 
		| BooleanObject (_, _, raw_bool) -> raw_bool
		| _ -> failwith "Tried to unbox a non-boolean object!"

	and get_value_location (value) = 
		match value with
		| Object (loc, _, _) -> loc
		| StringObject (loc, _, _)  -> loc
		| IntegerObject (loc, _, _)  -> loc
		| BooleanObject (loc, _, _)  -> loc
		| Void -> 0

	and get_value_type (value) = 
		match value with
		| Object (_, type_name, _)  -> type_name
		| StringObject (_, type_name, _) -> type_name
		| IntegerObject (_, type_name, _) -> type_name
		| BooleanObject (_, type_name, _) -> type_name
		| Void -> failwith "Void has no type."

	and get_value_attributes (value) =
		match value with
		| Object (_, _, alist) -> alist
		| StringObject (_, _, _) -> []
		| IntegerObject (_, _, _) -> []
		| BooleanObject (_, _, _) -> []
		| Void -> [] (* Dispatch on void? *)

	and new_location () =
		location_counter := !location_counter + 1 ;
		!location_counter
 	in

	(* Deserialization *)
	let class_map = read_cool_class_map () in
	let imp_map = read_cool_imp_map () in
	let parent_map = read_cool_parent_map () in
	let _ = read_cool_ast () in
	()
	(* Evaluation *)
(* 	let env = EnvMap.empty in
	let store = StoreMap.empty in
	let self_object = Object (-1, "", []) in
	let main_object = ("0", "Main", New ("0", "Main")) in
 	let main_call = ("0", "Object", DynamicDispatch(main_object, ("0", "main"), [])) in

	eval_expression (class_map, imp_map, parent_map, self_object, store, env, main_call) ; *)

end ;; 

main () ;;