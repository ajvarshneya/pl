class Main inherits IO {
	a : Int <- a + 3;
	b : Int <- b + a + 2;
	main () : Object {
		{
			out_int (b);
		}
	};
};