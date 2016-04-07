class Main inherits IO {
	main() : Object {
		let
			a : Int <- 1,
			b : Int <- 2,
			c : Int
		in {
			c <- a + b;
			c + a;
		}
	};
};