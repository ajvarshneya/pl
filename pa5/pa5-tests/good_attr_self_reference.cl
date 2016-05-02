class Main inherits IO {
	x : Int <- y + 1;
	y : Int <- x + 7;

	main() : Object {
		{
			out_int(x);
			out_string("\n");
			out_int(y);
			out_string("\n");
		}
	};
};