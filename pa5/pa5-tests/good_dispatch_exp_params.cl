(* Order of expression eval:
 * 1. Args are evaluated 
 * 2. Exp on lhs of dot is evaluated
 *)

class Main inherits IO {
	main() : Object {
		let
			x : Int <- 777,
			y : String <- "cool"
		in {
			{
				out_string(y);
				x <- 9001;
				y <- "test";
				self;
			}
			.some_method(x, y);

			{
				out_string(y);
				x <- 888;
				y <- "here";
				self;
			}
			@Main
			.some_method(x, y);	
		}
	};

	some_method(a : Int, b : String) : Object {
		{
			out_int(a);
			out_string(b);
		}
	};
};