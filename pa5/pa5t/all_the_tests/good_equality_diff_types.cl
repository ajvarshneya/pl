class Main inherits IO {

	main() : Object {
		let
			a : A <- new A,
			b : B <- new B
		in
			a = b
	};
};

class A {};
class B {};