class A{};
class Main inherits IO {
	a : A <- new A;
	b : A <- new A;
	main () : Object {
		if a <= b then out_string("its true") else out_string("its false") fi
	};
};