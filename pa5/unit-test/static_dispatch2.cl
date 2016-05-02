class A {
	a : Int <- 1;
	a () : Int {
		a
	};
	b () : Int {
		a <- a + 1234
	};
};

class B inherits A {
	a () : Int {
		a
	};
	b () : Int {
		a <- a + 456
	};
};

class Main inherits IO {
	a : A <- (new B);
	main () : Object {
		out_int(a.b() + a@A.a() + a.a())
	};
};