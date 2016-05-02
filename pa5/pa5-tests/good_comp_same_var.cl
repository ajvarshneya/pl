class Main inherits IO {
	main() : Object {
		let
			x : A
		in {
			if x = x then
				out_string("x = x\n")
			else
				out_string("x != x\n")
			fi;
		}
	};
};

class A {

};