class A {
	a : Int <- 1;
	a () : Int {
		a
	};
	b () : Int {
		a <- a + 1234
	};
};

class Main inherits IO {
	a : A <- (new A);
	main () : Object {
		out_int(a.b() + a.a())
	};
};