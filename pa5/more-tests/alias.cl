class A {
	a : Int;
	set (x : Int) : Int {
		a <- x
	};

	get () : Int {
		a
	};
};

class Main inherits IO {
	a : A <- new A;
	b : A <- a;
	main () : Object { 
		{
			b.set(123);
			out_int(a.get());
		}
	};
};