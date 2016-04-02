class Main inherits IO {

	main() : Object {
		let
			a : A <- new A,
			b : Int
		in
			b <- isvoid a
	};
};

class A {

};