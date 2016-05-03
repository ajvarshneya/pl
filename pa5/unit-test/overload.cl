class A {
	a : Int;

	get () : Int {
		a
	};
	set (x : Int) : Int {
		a <- x
	};
};

class B inherits A {
	b : Int;

	get () : Int {
		a + 1
	};
	set (x : Int) : Int {
		a <- (x + 1)
	};
};

class Main inherits IO {
	a : A <- new A;
	b : B <- new B;
	c : A <- b;
	main () : Object {
		{
			a.set(111);
			out_int(a.get());

			a@A.set(222);
			out_int(a.get());

			a.set(333);
			out_int(a@A.get());

			a@A.set(444);
			out_int(a@A.get());


			b.set(111);
			out_int(b.get());

			b@A.set(222);
			out_int(b.get());

			b@B.set(333);
			out_int(b.get());


			b.set(111);
			out_int(b@A.get());

			b@A.set(222);
			out_int(b@A.get());

			b@B.set(333);
			out_int(b@A.get());


			b.set(111);
			out_int(b@B.get());

			b@A.set(222);
			out_int(b@B.get());

			b@B.set(333);
			out_int(b@B.get());


			c.set(111);
			out_int(c.get());

			c@A.set(222);
			out_int(c.get());

			c.set(111);
			out_int(c@A.get());

			c@A.set(222);
			out_int(c@A.get());


		}
	};
};