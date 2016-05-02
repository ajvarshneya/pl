class Main inherits IO {
	a : Int <- 3;
	main () : Object {
		{
			while (a < 10) loop a <- a + 1 pool;
			out_int(a);
		}
	};
};