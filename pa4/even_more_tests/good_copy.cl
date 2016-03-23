class Main {
	main() : Object {
		let
			a : A,
			b : A
		in {
			a <- new A;
			b <- a.copy();
		}
	};
};

class A {
};

class B inherits A {
};
