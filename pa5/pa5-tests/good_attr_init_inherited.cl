class Main inherits A {
	x : Int <- y + 1;

	main() : Object {
		{
			out_int(x);
			out_string("\n");
			out_int(y);
			out_string("\n");
		}
	};
};

class A inherits IO {
	y : Int <- 777;
};