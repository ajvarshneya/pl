class Main inherits IO {
	b : Bool <- true;
	main () : Object {
		if b then out_string("its true") else out_string("its false") fi
	};
};