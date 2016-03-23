class Main inherits IO {
	main() : Object {
		let
			b : B <- new B
		in
			b <- b.a()
	};
};

class A {
	a() : A {
		self
	};
};

class B inherits A {
};