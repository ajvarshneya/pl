class Main inherits IO {
	a : Int <- 1;
	main () : Object {
		{
			while (a < 300) loop 
			{
				out_int(a);
				a <- a * 7;
			} pool;
		}
	};
};