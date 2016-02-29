class Main inherits IO {
	main() : Object {
		let b : B <- (new B).a() in {
			3;
		}
	};
};

class A {
	a() : A {
		{
			self;
		}
	};
};

class B inherits A {
	whatever : Int;
};