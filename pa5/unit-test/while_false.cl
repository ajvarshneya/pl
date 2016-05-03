class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int in {
			while(a < 10) loop {
				a <- 1234;
			} pool;
			out_int(a);
		}
	};
};