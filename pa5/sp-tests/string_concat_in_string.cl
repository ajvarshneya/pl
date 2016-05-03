class Main inherits IO {
	main() : Object {
		let
			s1 : String,
			s2 : String
		in {
			s1 <- in_string();
			s2 <- in_string();
			out_string(s1.concat(s2));
			out_string("\n");
		}
	};
};