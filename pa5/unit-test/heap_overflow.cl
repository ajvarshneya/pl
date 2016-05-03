class A {
	a : A;
	init() : Object {
		{
			a <- new A;
			a.init();
		}
	};
};

class Main inherits IO {
	main() : Object {
		(new A).init()
	};
};