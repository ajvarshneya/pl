class Main inherits IO {
	main() : Object {
		let
			a : Int,
			b : Int
		in {
			a <- in_int();
			b <- in_int();
			out_int(a);
			out_string("\n");
			out_int(b);
			out_string("\n");
		}
	};
};