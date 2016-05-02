class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : String,
			z : Bool <- {
				x <- 777;
				y <- "cool";
				true;
			}
		in {
			out_int(x);
			out_string(y);
			if z then
				out_string("true")
			else
				out_string("false")
			fi;
		}
	};
};