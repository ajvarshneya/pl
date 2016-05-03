class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : Int
		in {
			while {
				y <- 777;
				x < 10;
			} loop
				x <- x + 1
			pool;
			out_int(x);
			out_string("\n");
			out_int(y);
			out_string("\n");
		}
	};
};