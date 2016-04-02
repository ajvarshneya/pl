class Main inherits IO {
	main() : Object {
		{
			let a : A <- new A in
			a@SELF_TYPE.a(3);
		}
	};
};

class A {
	a() : Int {
		{
			"toaster";
		}
	};
};