class Main inherits IO {
	a : Int;
	b : Int <- 1;
	c : Int <- 2;
	d : Int <- 4;
	e : Int <- 2;
	f : Int <- 0;
	g : Int <- 0;
	h : Int <- 3;
	i : Int;
	j : Int <- 3;
	k : Int <- 2;
	x : Int;
	y : Int <- 1;
	z : Int <- 8;
	main() : Object {
		let a : Int,
			b : Int,
			c : Int,
			d : Int in {
				a <- ~(2 * 3 + 4 / 2 * 1 / 8 + 4 - 2 / 2 + 1); -- 76
				b <- a - b + c * d; -- 76
				a <- a + b; -- 152
				b <- 8 / 8 + 3 - 1 * 2 / 2; -- 1333
				c <- a / b + c * 4 - 1; -- -11111
				d <- 2 / 1 + 8 - c + a + b; -- 32706
				e <- a + b + c + d + e + f + g + h + x + y + z; -- 10951513
				f <- a * b - c + d * y / 3 + 2 / k - 1; -- 184849542
				g <- 1 / 1 * 2; -- 222
				h <- a * b * c * d * e * f / 2 + 1; -- 486074
				i <- z - b * 3 + c * h - i  + j / 1; -- -2033798106
				j <- z * x + y - b + e + f; -- 206728032
				-- out_int(j);
				j <- z * x + y - b + e + f / g - k + i * 2; -- 453590395
				k <- 1 * 4 / 3 - 4 + 3; -- -97176
				x <- 3 / 3 - d; -- -31540
				y <- g * h * i + j / (k+1) * 1 + a + b + c; -- -1065254571
				z <- a + b + c + d + e + f + g + h + i + x + y + z; -- 1392193598
			}
	};
};