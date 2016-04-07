class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int
		in {
			{
				{a <- 1;};
				{b <- a;};
				{out_int(b);};
			};
		}
	};
};