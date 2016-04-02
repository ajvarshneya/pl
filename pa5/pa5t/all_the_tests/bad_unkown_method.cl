class Main inherits IO {

	main() : Object {
		let
			a : A <- new A
		in
			a.bad_method()
	};
};

class A {};