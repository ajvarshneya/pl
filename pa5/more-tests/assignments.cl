class Main inherits IO {
	a : Int <- 1;
	b : Int <- 2;
	c : Int <- b;
	d : Int <- a;
	main () : Object { 
		let e : Int <- c,
			f : Int <- d in
			{
				out_int(e);
				out_int(f);
			}
	};
};