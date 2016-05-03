class Main inherits IO {
	main() : Object {
		let
			s1 : String <- "hello cool\n",
			s2 : String
		in {
			out_string(s1.concat(s2));
			out_string(s2.concat(s1));
		}
	};
};
