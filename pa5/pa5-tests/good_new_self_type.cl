class Main inherits IO {
	main() : Object {
		let
			s : SELF_TYPE
		in
			out_string((s <- new SELF_TYPE).type_name())
	};
};