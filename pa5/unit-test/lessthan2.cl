class A {};
class Main inherits IO {
	a : String <- "123";
	b : String <- "456";
	main () : Object {
		if a < b then out_string("its true") else out_string("its false") fi
	};
};