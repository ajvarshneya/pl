class Main {
	main() : Object {
		let
			a : A,
			b : B
		in {
			b <- new B;
			a <- b.copy();
		}
	};
};

class A {
};

class B inherits A {
};
