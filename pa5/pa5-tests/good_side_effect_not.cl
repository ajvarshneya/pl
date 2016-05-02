class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : String,
			a : Int,
			b : String
		in {
			out_int(
				~{
					x <- 9001;
					y <- "cool";
					777;
				}
			);
			out_int(x);
			out_string(y);

			if not {
				b <- "test";
				false;
			}
			then
				a <- 1
			else
				a <- 2
			fi;

			out_int(a);
			out_string(b);
		}
	};
};