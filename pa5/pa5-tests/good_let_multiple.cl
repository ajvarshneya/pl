class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : Int <- 7,
			z : Int <- x + y
		in {
			out_int(x);
			out_int(y);
			out_int(z);
		}
	};
};