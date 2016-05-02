class Main {
	main() : Object {
		0
	};
};

class A {
	this : SELF_TYPE;
};

class B inherits A {
	some_method() : B {
		this
	};
};
