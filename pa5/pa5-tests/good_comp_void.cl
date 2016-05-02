class Main inherits IO {
	main() : Object {
		let
			x : A,
			y : B
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