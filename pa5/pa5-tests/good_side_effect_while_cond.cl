class Main inherits IO {
	x : Int;
	main() : Object {
		{
			while {
				x <- 5;
				x < 4;
			}
			loop
				0
			pool;
			out_int(x);
		}
	};
};