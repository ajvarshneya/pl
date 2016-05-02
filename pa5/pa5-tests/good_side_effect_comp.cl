class Main inherits IO {
	main() : Object {
		let
			x : Int,
			y : String,
			a : Int <- 888,
			b : String
		in {
			{
				x <- 777;
			} < {
				y <- "cool";
				888;
			};

			out_int(x);
			out_string(y);

			-- Make sure e2 is evaluated with store S2
			if {
				a <- 777;
				b <- "test";
				777;
			} = a
			then
				out_string("equals")
			else
				out_string("not equals")
			fi;


		}
	};
};