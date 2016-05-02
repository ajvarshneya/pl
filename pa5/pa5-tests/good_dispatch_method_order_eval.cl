class Main inherits IO {
	main() : Object {
		let
			x : Int <- 1,
			y : Int,
			z : Int
		in {
			some_method(
				{
					y <- 2;
					x;
				},
				{
					z <- 3;
					y;
				},
				{
					x <- 777;
					z;
				}
			);
		}
	};

	some_method(a : Int, b : Int, c : Int) : Object {
		{
			out_int(a);
			out_int(b);
			out_int(c);
		}
	};
};