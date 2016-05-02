-- test attribute initialization in new
class Main inherits IO {
	x : Int <- 9001;
	a : A <- {
		x <- 888;
		new A;
	};

	main() : SELF_TYPE {
		{
			out_int(x);
			out_int(a.get_val());
			out_int(a.get_default());
		}
	};
};

class A {
	aa : AA <- new AA;

	get_val() : Int {
		aa.get_aaa().get_val()
	};

	get_default() : Int {
		aa.get_default()
	};
};

class AA {
	aaa : AAA <- new AAA;

	get_aaa() : AAA {
		aaa
	};

	get_default() : Int {
		aaa.get_default()
	};
};

class AAA {
	val : Int <- 777;
	default : Int;

	get_val() : Int {
		val
	};

	get_default() : Int {
		default
	};
};