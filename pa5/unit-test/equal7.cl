class Main inherits IO {
	a : Bool <- true;
	b : Bool <- false;
	main () : Object {
		if a = b then out_string("its true") else out_string("its false") fi
	};
};