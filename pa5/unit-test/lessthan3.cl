class A {};
class Main inherits IO {
	a : Int <- 12345;
	b : Int <- 45678;
	main () : Object {
		if a < b then out_string("its true") else out_string("its false") fi
	};
};