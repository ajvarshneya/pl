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
	| Let of (cool_let_binding list)																	(* let \n binding-list *)
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
| Void of string
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
		let input = read () in
		let k = int_of_string (input) in 			(* Read number of elements *)
		let lst = range k in 						(* Get a range for that number *)
		List.map (fun _ -> worker ()) lst 			(* Apply worker k times *)
	in


	(* AST deserialization *)
	let rec read_cool_ast () =						(* program *)
		read_list read_cool_class

	and read_cool_identifier () =					(* identifier *)
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

	and read_cool_feature () =						(* feature *)
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

	(* Helper functions *)
	let get_value_type (value) = 
		match value with
		| Object (type_name, alist) -> type_name
		| StringObject (type_name, raw_string) -> type_name
		| IntegerObject (type_name, raw_int32) -> type_name
		| BooleanObject (type_name, raw_bool) -> type_name
		| Void (empty) -> ""

	and get_value_attributes (value) =
		match value with
		| Object (type_name, alist) -> alist
		| StringObject (type_name, raw_string) -> []
		| IntegerObject (type_name, raw_int32) -> []
		| BooleanObject (type_name, raw_bool) -> []
		| Void (empty) -> failwith "Dispatch on void."

	and new_location () =
		location_counter := !location_counter + 1 ;
		!location_counter
	in

	(* Interpret *)
	let rec eval_expression (class_map, imp_map, parent_map, self_object, store, env, exp) =
		let (lineno, static_type, exp_kind) = exp in
 		match exp_kind with
		| Assign (var, rhs) -> failwith ("Expression not yet handled ")
	 	| DynamicDispatch (receiver, mident, args) -> eval_dynamic_dispatch (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| StaticDispatch (receiver, stype, mident, args) -> failwith ("Expression not yet handled ")
		| SelfDispatch (mident, args) -> failwith ("Expression not yet handled ")
		| If (pred_exp, then_exp, else_exp) -> failwith ("Expression not yet handled ")
		| While (pred_exp, body_exp) -> failwith ("Expression not yet handled ")
		| Block (exp_list) -> failwith ("Expression not yet handled ")
		| New (type_ident) -> eval_new (class_map, imp_map, parent_map, self_object, store, env, exp_kind)
		| IsVoid (exp) -> failwith ("Expression not yet handled ")
		| Plus (e1, e2) -> failwith ("Expression not yet handled ")
		| Minus (e1, e2) -> failwith ("Expression not yet handled ")
		| Times (e1, e2) -> failwith ("Expression not yet handled ")
		| Divide (e1, e2) -> failwith ("Expression not yet handled ")
		| LessThan (e1, e2) -> failwith ("Expression not yet handled ")
		| LessEqual (e1, e2) -> failwith ("Expression not yet handled ")
		| Equal (e1, e2) -> failwith ("Expression not yet handled ")
		| Not (exp) -> failwith ("Expression not yet handled ")
		| Negate (exp) -> failwith ("Expression not yet handled ")
		| Integer (constant) -> failwith ("Expression not yet handled ")
		| String (constant) -> failwith ("Expression not yet handled ")
		| Identifier (id) -> failwith ("Expression not yet handled ")
		| Boolean (constant) -> failwith ("Expression not yet handled ")
		| Let (let_bindings) -> failwith ("Expression not yet handled ")
		| Case (case_exp, case_elements) -> failwith ("Expression not yet handled ")
		| Internal (class_method) -> failwith ("Expression not yet handled ")

	and eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, exp_list) =
		match exp_list with
		| [] -> ([], store)
		| expression :: tl ->
			let (value, store) = eval_expression (class_map, imp_map, parent_map, self_object, store, env, expression) in
			let (value_list, store) = eval_expression_list (class_map, imp_map, parent_map, self_object, store, env, tl) in
			(value :: value_list, store)

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
 			let store3 = eval_dynamic_dispatch_init_params (store2, param_initializers) in

 			(* Extend attribute list with formal/location list, environment constructed from this list *)
 			let env_initializer = List.combine mformals locations in
 			let env_initializer = receiver_attributes @ env_initializer in

 			(* Create new environment out of attribute and formal identifiers / locations *)
 			let env2 = EnvMap.empty in
 			let env2 = eval_dynamic_dispatch_init_env (env2, env_initializer) in

 			(* Evaluate method body with receiver object as self and new environment *)
 			let (value1, store4) = eval_expression (class_map, imp_map, parent_map, value, store3, env2, mbody) in
 			(value1, store4)
 			
		| _ -> failwith "Invalid type identifier passed to eval_dynamic_dispatch."

	and eval_dynamic_dispatch_init_params (store, param_initializers) = 
		match param_initializers with
		| [] -> store
		| hd :: tl ->
			let (value, loc) = hd in
			let store = StoreMap.add loc value store in 
			eval_dynamic_dispatch_init_params (store, tl)

	and eval_dynamic_dispatch_init_env (env, env_initializer) =
		match env_initializer with
		| [] -> env
		| hd :: tl ->
			let (ident, loc) = hd in 
			let env = EnvMap.add ident loc env in
			eval_dynamic_dispatch_init_env (env, tl)

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

		| _ -> failwith "Invalid type identifier passed to eval_new."

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
			| "Integer" -> 
				let store = StoreMap.add loc (IntegerObject ("Int", Int32.of_int(0))) store in
				eval_new_init_attrs (store, tl)
			| "Bool" -> 
				let store = StoreMap.add loc (BooleanObject ("Bool", false)) store in
				eval_new_init_attrs (store, tl)
			| _ -> 
				let store = StoreMap.add loc (Void ("")) store in
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