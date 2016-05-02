class Main inherits IO {
	main() : Object {
		out_string(
			(new B)
				.some_method()
		)
	};
};

class A {
	some_method() : String {
		"cool"
	};
};

class B inherits A {
};