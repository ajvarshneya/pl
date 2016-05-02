class Main {
	main() : Object {
		let
			a : A
		in
			a <- (new A).some_method()
	};
};

class A {
	some_method() : SELF_TYPE {
		self
	};
};