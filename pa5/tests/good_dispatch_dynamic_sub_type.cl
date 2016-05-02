class Main {
	main() : Object {
		let
			a : A
		in
			a <- (new B).some_method()
	};
};

class A {
	some_method() : SELF_TYPE {
		self
	};
};

class B inherits A {

};