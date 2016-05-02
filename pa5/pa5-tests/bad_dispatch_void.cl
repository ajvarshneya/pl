class Main inherits IO {
	main() : Object {
		let
			a : A
		in
			-- dispatch on void
			a
				.some_method()
	};
};

class A {
	some_method() : Object {
		0
	};
};