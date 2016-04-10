class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int,
			d : Int in {
				a <- 76;
				b <- a - b + c * d;
				a <- a + b;
				c <- a / b + c;
				out_int(c);
			}
	};
};