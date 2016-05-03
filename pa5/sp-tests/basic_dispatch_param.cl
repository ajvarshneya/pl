class Main inherits IO {
	main() : Object {
		let
			a : A <- new A
		in {
			out_int(a.get_i());
			out_string("\n");
			some_method(a);
			out_int(a.get_i());
			out_string("\n");
		}
	};

	some_method(aa : A) : Object {
		aa.set_i()
	};
};

class A {
	i : Int <- 9001;

	set_i() : Object {
		i <- 777
	};

	get_i() : Int {
		i
	};

};