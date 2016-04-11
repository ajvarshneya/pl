class A {
	a(a : Int, b : Int) : Object {
		{
			a + b;
		}
	};
};

class Main inherits IO {
	main() : Object {
		(new A)@A.a(777, 444)
	};
};