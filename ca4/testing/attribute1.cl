class Main inherits IO {
	a : Int <- b + 7;
	b : Int <- a + 9001;
	main() : Object {
		{
			a <- a + b;
			b <- 100 - a * b / 2;
		}
	};
};