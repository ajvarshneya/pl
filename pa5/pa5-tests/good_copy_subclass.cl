class Main inherits IO {
	main() : Object {
		let
			a : A <- new A,
			a2 : A,
			b : B <- new B
		in {
			out_int(a.get_c().get_val());
			out_string("\n");

			a2 <- a.copy();
			a2.get_c().set_val(888);
			out_int(a.get_c().get_val());		-- prints 888 b/c shallow copy
			out_string("\n");

			out_string(
				(b@A.copy()).type_name()
			);
		}
	};
};

class A {
	c : C <- (new C).set_val(777);

	get_c() : C {
		c
	};
};

class B inherits A {
};

class C {
	val : Int;

	set_val(v : Int) : SELF_TYPE {
		{
			val <- v;
			self;
		}
	};

	get_val() : Int {
		val
	};
};