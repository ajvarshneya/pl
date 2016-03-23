class Main {
	main() : Object {
		let
			int : Int,
			b : B <- new B
		in
			some_method(
				int,
				b)
	};

	some_method(x : Int, y : A) : Object {
		0
	};
};

class A {

};

class B inherits A {

};