class Main inherits IO {
	main() : Object {
		let
			s : String <- "hello cool\n"
		in {
			out_string(s);
			out_int(s.length()).out_string("\n");
		}
	};
};