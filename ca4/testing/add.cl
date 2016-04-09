class Main inherits IO {
	main() : Object {
		let a : Int <- 111,
			b : Int <- 444 in {
				a <- a + b;
				b <- a / 5;
				a <- ~a / 5 * 6 - 66 + b;
			}
	};
};