class Main inherits IO {
	main() : Object {
		let
			s1 : String <- "abcdef",
			s2 : String <- "123456"
		in {
			-- initial values
			out_string(s1).out_string("\n");
			out_string(s2).out_string("\n");

			-- concat
			out_string(s1.concat(s2)).out_string("\n");

			-- check values unchanged
			out_string(s1).out_string("\n");
			out_string(s2).out_string("\n");
		}
	};
};