class Main inherits IO {
	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int,
			d : Bool
		in {
			a <- 111;
			b <- 222;
			c <- 333;
			a <- b + c; -- 555
			out_int(a);
			out_string("\n");
			a <- b - c; -- -111
			out_int(a);
			out_string("\n");
			a <- b / c; -- 0
			out_int(a);
			out_string("\n");
			a <- b * c; -- 73926
			out_int(a);
			out_string("\n");
			a <- ~a;	-- -73926
			out_int(a);
			out_string("\n");
			d <- not d; -- true
		}
	};
};