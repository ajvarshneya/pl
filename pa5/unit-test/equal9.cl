class Main inherits IO {
	a : Bool <- false;
	b : Bool;
	main () : Object {
		if a = b then out_string("its true") else out_string("its false") fi
	};
};