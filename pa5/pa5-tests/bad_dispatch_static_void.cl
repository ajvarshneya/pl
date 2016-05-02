class Main inherits IO {
	main() : Object {
		let
			a : A
		in
			-- dispatch on void
			a
				@A
				.some_method()
	};
};

class A {
	some_method() : Object {
		0
	};
};