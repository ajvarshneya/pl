class A {
	a () : SELF_TYPE {
		self
	};
};

class Main inherits IO {
	a : A <- (new A);
	main () : Object {
		a.a()
	};
};