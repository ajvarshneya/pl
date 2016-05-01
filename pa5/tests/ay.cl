class B {
	a : Int;
	lmao() : Object {
		a <- a + 123
	};

};

class Main inherits IO {
	main() : Object {
		(new B).lmao()
	};
};