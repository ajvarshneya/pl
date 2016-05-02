class Main inherits IO {

	main() : Object {
		let
			a : A
		in
			a <- new B
	};
};

class A {

};

class B inherits A {

};