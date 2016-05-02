class Main inherits IO {
	main() : Object {
		let x : B <- new A in x.b()
	};
};

class A {
	a() : Int {
		1
	};
};

class B inherits A {
	b() : Int {
		1
	};
};