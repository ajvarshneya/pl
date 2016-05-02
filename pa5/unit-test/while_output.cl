class Main inherits IO {
	a : Int;
	main () : Object {
		{
			while (a < 10) loop 
			{
				out_int (a);
				a <- a + 1;
			}
			pool;
		}
	};
};