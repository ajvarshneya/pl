class Main inherits IO {
	main() : Object {
		let
			s : String <- "abcdefg"
		in {
			out_string(s).out_string("\n");
			out_string(s.substr(0, 0)).out_string("\n");
			out_string("".substr(0, 0)).out_string("\n");
			out_string(s).out_string("\n");
		}
	};
};