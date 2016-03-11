-- Tests plus, minus, mult, div
class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int,
			d : Int
		in {
			b <- 7;
			c <- 3;
			a <- b + c;		-- a = 10
			out_int(a);
			d <- b - c; 	-- d = 4
			out_int(d);
			a <- b * c;		-- a = 21
			out_int(a);
			d <- a / b;		-- d = 3
			out_int(d);
			b <- ~b;		-- b = -7
			out_int(b);
		}
	};
};