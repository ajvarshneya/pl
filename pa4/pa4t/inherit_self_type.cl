class Main inherits IO {
	main() : Object {
		3
	};
};

class A inherits SELF_TYPE{
	a() : A {
		{
			self;
		}
	};
};