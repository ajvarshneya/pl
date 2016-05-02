class A {};
class Main inherits IO {
	a : Int <- 11;
	b : Int <- 22;
	d : Int;
	f : Int <- 33;
	main () : Object {
		let a : Int,
			b : Int <- 1,
			c : Int <- 2,
			d : Int <- 3,
			e : Int <- 4 in{
				a <- a + b;
				a <- a + 1;
				b <- a * c;
				c <- a / d;
				d <- a - e;
				e <- a + b + c + d + 1;
				out_int(e);
			}
	};
};