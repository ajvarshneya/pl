class Main {
	main() : Object {
		(new A)@A.some_method(777, 1+2+3)
	};
};

class A {
	some_method(a : Int, b : Int) : Object {
		123
	};
};