class Main inherits IO {
	a : Bool <- true;
	b : Bool <- false;
	main () : Object {
		if a <= b then out_string("yes") else out_string("no") fi
	};
};