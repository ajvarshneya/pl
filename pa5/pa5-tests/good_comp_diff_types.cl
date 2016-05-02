class Main inherits IO {
	main() : Object {
		let
			x : A <- new A,
			y : B <- new B
		in {
			if x = y then
				out_string("x = y\n")
			else
				out_string("x != y\n")
			fi;
		}
	};
};

class A {

};

class B {

};