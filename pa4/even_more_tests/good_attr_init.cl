class Main inherits IO {

	x : Int <- x + 5;

	main() : Object {
		{
			out_int(x);
			out_string("\n");
		}
	};
};