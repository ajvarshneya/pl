class Main inherits IO {
	x : Int <- y + 7;
	y : Int <- x + 9001;

	main() : Object {
		{
			out_int(x);
			out_int(y);
		}
	};
};