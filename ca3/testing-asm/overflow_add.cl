class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int
		in {
			-- MAX INT: 2147483647
			a <- 2147483647;
			b <- 2147483647;
			c <- a + b;
			out_int(c);
		}
	};
};