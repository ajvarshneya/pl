class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int,
			r1 : Int,
			r2 : Int,
			r3 : Int,
			r4 : Int,
			r5 : Int,
			r6 : Int,
			r7 : Int,
			r8 : Int,
			r9 : Int,
			r10 : Int,
			r11 : Int,
			r12 : Int,
			r13 : Int,
			r14 : Int,
			r15 : Int,
			r16 : Int,
			x : Int,
			y : Int,
			z : Int
		in {
			r1 <- 1;
			r2 <- 2;
			r3 <- 3;
			r4 <- 4;
			r5 <- 5;
			r6 <- 6;
			r7 <- 7;
			r8 <- 8;
			r9 <- 9;
			r10 <- 10;
			r11 <- 11;
			r12 <- 12;
			r13 <- 13;
			r14 <- 14;
			r15 <- 15;
			r16 <- 16;

			a <- 27 / 3;
			b <- 1000/3;
			c <- 1234*83;
			-- out_int(a);
			-- out_int(b);
			-- out_int(c);

			x <- r1;
			y <- r16;
			z <- r4;
			x <- y / z;
			out_int(x);

			x <- y / z;
			x <- r2 / r3;
			x <- r15 / r5;
			x <- r10 / r11;
			x <- r7 / r2;
			out_int(x);

			out_int(b/a);
			out_int(c/b);
			out_int(c/a);
		}
	};
};