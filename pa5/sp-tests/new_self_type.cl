class Main inherits IO {
	main() : Object {
		let
			a : A <- new A,
			b : A
		in {
			a.some_method(); 		-- type A
			a <- new B;

			b <- a.get_self();
			a.some_method(); 		-- type B
			b.some_method(); 		-- type B
		}
	};
};

class A inherits IO {
	get_self() : SELF_TYPE {
		new SELF_TYPE
	};

	some_method() : Object {
		out_string("obj has dynamic type A\n")
	};
};

class B inherits A {
	some_method() : Object {
		out_string("obj has dynamic type B\n")
	};
};