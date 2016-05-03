class A {
	a : Int;
	b : Int <- 1;
	c : String;
	d : String <- "hello";
	get_a() : Int {
		a
	};
	set_a(x : Int) : Object {
		a <- x
	};
	get_b() : Int {
		b
	};
	set_b(x : Int) : Object {
		b <- x
	};
	get_c() : String {
		c
	};
	set_c(x : String) : Object {
		c <- x
	};
	get_d() : String {
		d
	};
	set_d(x : String) : Object {
		d <- x
	};
};

class B inherits A {
	e : Int;
	f : Int <- 2;
	g : String;
	h : String <- "goodbye";
	get_e() : Int {
		e
	};
	set_e(x : Int) : Object {
		e <- x
	};
	get_f() : Int {
		f
	};
	set_f(x : Int) : Object {
		f <- x
	};
	get_g() : String {
		g
	};
	set_g(x : String) : Object {
		g <- x
	};
	get_h() : String {
		h
	};
	set_h(x : String) : Object {
		h <- x
	};
};

class Main inherits IO {
	main() : Object {
		let b : B <- (new B) in {
			out_int(b.get_a());
			out_int(b.get_b());
			out_string(b.get_c());
			out_string(b.get_d());

			out_int(b.get_e());
			out_int(b.get_f());
			out_string(b.get_g());
			out_string(b.get_h());

			b.set_a(123);
			b.set_b(456);
			b.set_c("ay");
			b.set_d("lmao");
			b.set_e(111);
			b.set_f(222);
			b.set_g("xD");
			b.set_h("gg");

			out_int(b.get_a());
			out_int(b.get_b());
			out_string(b.get_c());
			out_string(b.get_d());

			out_int(b.get_e());
			out_int(b.get_f());
			out_string(b.get_g());
			out_string(b.get_h());
		}
	};
};