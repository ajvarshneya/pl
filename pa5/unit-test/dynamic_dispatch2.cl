class A {
	a () : Int {
		1234
	};
};

class Main inherits IO {
	a : A <- (new A);
	main () : Object {
		out_int(a.a())
	};
};