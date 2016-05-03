class Main inherits IO {
	main() : Object {
		let
			a : A
		in {
			if a <= a then
				out_string("a <= a\n")
			else
				out_string("nope\n")
			fi;
		}
	};
};

class A {
};