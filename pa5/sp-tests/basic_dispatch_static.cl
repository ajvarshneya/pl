class Main {
	main() : Object {
		(new A)@A.some_method(777)
	};
};

class A {
	some_method(a : Int) : Object {
		123
	};
};