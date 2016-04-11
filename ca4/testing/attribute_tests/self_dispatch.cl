class A {
	a(x : Int, y : Int) : Int {
		x * y
	};
};

class B inherits A {
	a(x : Int, y : Int) : Int {
		x - y
	};

	b() : B {
		self
	};
};

class Main inherits IO {
	a(x : Int, y : Int) : Int {
		x + y
	};

	main() : Object {
		a(777, 444) + (new A).a(111, 222) + (new B).b().a(123, 456)
	};
};