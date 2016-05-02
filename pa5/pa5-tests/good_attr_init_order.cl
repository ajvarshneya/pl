class Main inherits IO {
	main() : Object {
		out_string(
			(new B).get_attr_3()
		)
	};
};

class A inherits IO {
	attr_1 : Int <- 777;
	attr_2 : String <- "cool";

	get_attr_1() : Int {
		attr_1
	};

	get_attr_2() : String {
		attr_2
	};
};

class B inherits A {
	a : A <- new A;
	attr_3 : String <- {
		out_int(a.get_attr_1());
		out_string(a.get_attr_2());
		out_int(attr_1);
		out_string(attr_2);
		"test";
	};

	get_attr_3() : String {
		attr_3
	};
};