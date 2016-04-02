class A {
	f() : Object {
		1
	};
};

class Main inherits IO {
	main() : Object {
		let a : A in {
			a@A.f();
		}
	};
};