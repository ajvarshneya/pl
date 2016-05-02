class Main inherits IO {
	b : Bool <- false;
	main () : Object {
		if b then out_string("its true") else out_string("its false") fi
	};
};