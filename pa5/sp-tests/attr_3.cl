class Main inherits IO {
	a : Int;
	b : Int <- 111;
	c : Int <- 2222;
	d : Int <- 44;
	e : Int <- 2;
	f : Int <- 0000;
	g : Int <- 0;
	h : Int <- 33;
	i : Int;
	j : Int <- 3095;
	k : Int <- 2;
	x : Int;
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
				e <- a + b + c + d + e + f + g + h + x + y + z;
				f <- a * b - c + d * y / 3 + 2 / k - 128371283;
				g <- 123 / 111 * 222;
				h <- a * b * c * d * e * f / 222 + 111111;
				i <- z - b * 3918203 + c * h - i  + j / 111;
				j <- z * x + y - b + e + f / g - k + i * 222222;
				k <- 102193 * 123123 / 06359 - 49594 + 3;
				x <- 388338 / 333 - d;
				y <- g * h * i + j / k * 123 + a + b + c;
				z <- a + b + c + d + e + f + g + h + i + x + y + z;
				-- out_int(z);
			}
	};
};