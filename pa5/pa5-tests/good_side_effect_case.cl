class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : String,
			xx : Int,
			yy : String
		in {
			case {
				x <- 777;
				y <- "cool";
				x;
			} of
				a : Int => {
					out_string("test");
					xx <- 888;
					yy <- "string here";
				};
				b : Object => out_string("default");
			esac;

			out_int(x);
			out_string(y);
			out_int(xx);
			out_string(yy);
		}
	};
};