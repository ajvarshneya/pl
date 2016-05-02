class Main inherits IO {
	main() : Object {
		let
			str : String
		in {
			-- str is set to "" since input contains null char
			str <- in_string();
			out_string("output: ");
			out_string(str);
			out_string("\n");
		}
	};
};