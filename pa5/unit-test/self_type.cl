class Main inherits IO {
	a : Int <- 1;
	main () : Object {
		let a : Main <- (new SELF_TYPE) in
		{
			a.set_a(123); 
			out_int(a.get_a());
		}
	};

	set_a (x : Int) : Int {
		a <- x
	};

	get_a () : Int {
		a
	};
};