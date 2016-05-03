class A inherits IO {
	a : Int <- 123;
	lmao() : A {
		{
			a <- a + 1;
			self;
		}
	};
	bee() : B {
		{
			(new B).set_b(111);
		}
	};
	get_a() : Int {
		a
	};
	set_a(x : Int) : SELF_TYPE {
		{
			a <- x;
			self;
		}
	};
};

class B inherits A {
	b : Int <- 456;
	ay() : A {
		self
	};

	lmao() : A {
		{
			a <- a + 123;
			self;
		}
	};

	bee() : B {
		(new B).set_a(123125)
	};

	set_b(x : Int) : SELF_TYPE {
		{
			b <- x;
			self;
		}
	};
};

class Main inherits IO {
	main() : Object {
		{
			out_int((new B)@B.ay().lmao()@A.lmao().get_a());
			out_int((new B).bee()@B.bee()@A.set_a(120391).bee().ay()@A.lmao().set_a(8888).get_a());
			out_int((new B).lmao().lmao().lmao().get_a());
			out_int((new B).lmao()@A.lmao()@A.lmao().get_a());
		}
	};
};