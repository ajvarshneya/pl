class Main inherits IO {
	a : Int <- 1;
	b : Int <- 2;
	c : Int <- 3;
	d : Main;
	main () : Object {
		{
			d <- new Main;
			set_a(123);
			set_b(456);
			set_c(789);
			set_d(copy());
			d.set_a(111);
			d.set_b(222);
			d.set_c(333);
			out_int(a);
			out_int(b);
			out_int(c);
			out_int(d.get_a());
			out_int(d.get_b());
			out_int(d.get_c());
			d.set_d(copy());
			d.get_d().set_a(999);
			d.get_d().set_b(888);
			d.get_d().set_c(777);
			out_int(d.get_d().get_a());
			out_int(d.get_d().get_b());
			out_int(d.get_d().get_c());
		}
	};

	set_a(x : Int) : Int {
		a <- x
	};
	set_b(x : Int) : Int {
		b <- x
	};
	set_c(x : Int) : Int {
		c <- x
	};
	set_d(x : Main) : Main {
		d <- x
	};

	get_a() : Int {
		a
	};
	get_b() : Int {
		b
	};
	get_c() : Int {
		c
	};
	get_d() : Main {
		d
	};
};