class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int
		in {
			a <- 7;
			b <- 10;
			if a < b then
				c <- 777
			else
				c <- 9001
			fi;

			out_int(c);
		}
	};
};