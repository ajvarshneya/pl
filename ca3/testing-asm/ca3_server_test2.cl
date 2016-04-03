class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int in {

			a <- 1;
			a <- 1;
			a <- 1;

			b <- a + 1;
			b <- a + 1;
			b <- a + 1;

			c <- 3;
			c <- 3;
			c <- 3;

			out_int(b);
		}
	};
};