class A {
	a(x : Int, y : Int) : Int {
		x * y
	};

	c(x : Int, y : Int) : Int {
		123456
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
		a(777, 444) + (new A).a(111, 222) + (new B).b().a(123, 456) + (new B).c(888, 999)
	};
};