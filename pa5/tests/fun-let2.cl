class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int <- a + 123,
			a : Int <- b + 456,
			c : Int <- 123456 + a + b in {
				out_int(a);
				out_int(b);
				out_int(c);
		}
	};
};