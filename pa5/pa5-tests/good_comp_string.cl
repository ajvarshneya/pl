class Main inherits IO {
	main() : Object {
		let
			x : String <- "abc",
			y : String <- "ABC"
		in {
			if x < y then
				out_string("x < y\n")
			else
				out_string("x !< y\n")
			fi;
		}
	};
};

class A {

};