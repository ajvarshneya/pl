class Main inherits IO {
	a : String <- "1234";
	b : String;
	main () : Object {
		{
			out_string(a);
			a <- in_string();
			out_string(a);
			b <- in_string();
			out_string(b);
		}
	};
};