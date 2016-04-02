class Main {
	main() : Object {
		let
			a : A,
			b : B
		in {
			a <- new B;
			b <- a.copy();
		}
	};
};

class A {
};

class B inherits A {
};
