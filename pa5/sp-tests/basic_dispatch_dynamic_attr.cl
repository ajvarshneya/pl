class Main {
	main() : Object {
		(new A).some_method(777)
	};
};

class A {
	x : Int <- 777;
	some_method(a : Int) : Int {
		{
			123;
			x;
		}
	};
};