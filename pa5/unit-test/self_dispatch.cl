class Main inherits IO {
	b : Int <- 123;
	a () : Int {
		b <- 234
	};

	main () : Object {
		out_int(a() + a() + b)
	};
};