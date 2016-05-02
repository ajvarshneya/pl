class Main {
	main() : Object {
		0
	};
};

class A {
	some_method() : Int {
		0
	};

	overriden_method() : Int {
		1
	};
};

class B inherits A {
	overriden_method() : Int {
		2
	};
};