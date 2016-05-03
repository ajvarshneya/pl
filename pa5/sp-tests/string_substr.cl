class Main inherits IO {
	main() : Object {
		let
			s : String <- "abcdefg"
		in {
			out_string(s).out_string("\n");
			out_string(s.substr(0, 3)).out_string("\n");
			out_string(s.substr(6, 1)).out_string("\n");
			out_string(s).out_string("\n");
		}
	};
};