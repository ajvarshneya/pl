class Main inherits Object {
	main() : Object { 0 };
};

class A {};

class B inherits A {
	method() : SELF_TYPE {
		let
			a : A <- new B
		in
			a
	};
};