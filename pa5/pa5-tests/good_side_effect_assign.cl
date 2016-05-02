class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : String
		in {
			x <- {
				y <- "cool";
				777;
			};

			out_int(x);
			out_string(y);
		}
	};
};