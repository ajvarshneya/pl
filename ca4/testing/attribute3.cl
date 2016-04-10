class Main inherits IO {
	a : Int;
	b : Int <- 111;
	c : Int <- 2222;
	d : Int <- 44;
	x : Int <- 4444;
	y : Int <- 10928310;
	z : Int <- 88;
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