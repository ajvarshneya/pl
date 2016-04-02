class Main inherits IO {
	b : B <- (new A);

	main() : Object {
		0
	};
};

class A {
	a() : A {
		self
	};
};

class B inherits A {
};