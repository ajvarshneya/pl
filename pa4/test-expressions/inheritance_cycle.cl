class Main inherits IO {
	main() : Object {
		{
			1;
		}
	};
};

class A inherits B {
	a : Int;
};

class B inherits A {
	a : Int;
};