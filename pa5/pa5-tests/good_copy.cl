class Main inherits IO {
	main() : Object {
		{
			let
				x : Int,
				y : Int
			in {
				x <- 5;
				y <- x.copy();
				x <- 7;
				out_int(x);
				out_int(y);
			};

			let
				x : String,
				y : String
			in {
				x <- "hello";
				y <- x.copy();
				x <- "cool";
				out_string(x);
				out_string(y);
			};
		}
	};
};