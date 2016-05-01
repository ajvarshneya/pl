class B {
	b : Int;
	set_b(a : Int) : Object {
		b <- a
	};
	get_b() : Int {
		b
	};
};

class A {
	a : B <- new B;
	get_a() : B {
		a
	};
};

class Main inherits IO {
	main() : Object {
		let a : A <- (new A),
			b : A in {
			a.get_a().set_b(123);
			b <- a.copy();
			out_int(a.get_a().get_b());
			out_int(b.get_a().get_b());
		}
	};
};