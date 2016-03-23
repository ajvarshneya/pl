class Main inherits IO {
	main () : Object {
		let a : Main <- new SELF_TYPE in {
			a.main();
			out_string("kool\n");
		}
	};
};