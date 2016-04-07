class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int
		in {
			-- MAX INT: 2147483647
			-- MIN INT: -2147483648
			a <- 2147483600;
			b <- 2147483607;
			c <- a * b;
			out_int(c);

			b <- ~2147483607;
			c <- a * b;
			out_int(c);

		}
	};
};