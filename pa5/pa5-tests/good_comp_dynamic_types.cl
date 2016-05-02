class Main inherits IO {
	main() : Object {
		let
			a : Object <- "cool",
			b : Object <- 777
		in {
			if a < b then
				out_string("a < b\n")
			else
				out_string("a !< b\n")
			fi;

			b <- "xyz";

			if a <= b then
				out_string("a < b\n")
			else
				out_string("a !< b\n")
			fi;

			a <- 888;
			b <- true;
			if a = b then
				out_string("a < b\n")
			else
				out_string("a !< b\n")
			fi;
		}
	};
};