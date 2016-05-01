class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int in {
			a <- 1;
			b <- a + 1;
			c <- b + a;
			a <- a + 1;
			b <- b + a + 1;
			c <- c + a + b;
			out_int(a);
			out_int(b);
			out_int(c);
		}
	};
};