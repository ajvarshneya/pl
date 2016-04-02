class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int in {
			while(a < 10) loop {
				a <- a + 1;
			} pool;
			out_int(a);
		}
	};
};