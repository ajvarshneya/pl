class Main inherits IO {
	main() : Object {
		let
			str : String
		in {
			str <- in_string();
			out_string(str);
			out_string("\n");
		}

	};
};