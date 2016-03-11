class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int
		in {
			a <- 2147483640;
			b <- 2147483000;
			c <- a + b;

			out_int(a);
			out_int(b);
			out_int(c);

			a <- a + a;
			out_int(a);

			b <- ~b;
			b <- b + b;
			out_int(b);
		}
	};
};