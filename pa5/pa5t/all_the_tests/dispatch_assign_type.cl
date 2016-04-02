class Main inherits IO {
	main() : Object {
		{
			let a : A <- new A in {
				a <- a.a(3);
			};
		}
	};
};

class A {
	a(b : Int) : Int {
		{
			3;
		}
	};
};