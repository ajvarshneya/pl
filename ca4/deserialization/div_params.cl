-- Tests that parameters are preserved across division
class Main inherits IO {

	main() : Object {
		let
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
			-- Set initial values
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

			-- Output initial values to validate
			out_int(r1);
			out_int(r2);
			out_int(r3);
			out_int(r4);
			out_int(r5);
			out_int(r6);
			out_int(r7);
			out_int(r8);
			out_int(r9);
			out_int(r10);
			out_int(r11);
			out_int(r12);
			out_int(r13);
			out_int(r14);
			out_int(r15);
			out_int(r16);
		}
	};
};