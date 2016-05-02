class Main inherits IO {
	main() : Object {
		let
			x : Int
		in {
			x <- 2147483600;
			x <- x * x;
			out_int(x);
			out_string("\n");

			x <- 2147483600;
			x <- x + x;
			out_int(x);
			out_string("\n");

			x <- ~2147483640;
			x <- x + x;
			out_int(x);
			out_string("\n");

			x <- 2147483600;
			x <- x * x / x;
			out_int(x);
			out_string("\n");
		}
	};
};