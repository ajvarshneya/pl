class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int,
			d : Int in {
				a <- ~(2 * 3 + 4 / 2 * 123 / 8 + 4 - 234 / 2 + 1);
				b <- a - b + c * d;
				a <- a + b;
				b <- 8888 / 8 + 333 - 111 * 2 / 2;
				c <- a / b + c * 4 - 11111;
				d <- 22334235 / 1111 + 8 - c + a + b;
			}
	};
};