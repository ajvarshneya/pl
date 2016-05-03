class Main inherits IO {
	a : Int <- 3;
	main () : Object {
		{
			while (a < 10) loop a <- in_int() pool;
			out_int(a);
		}
	};
};