class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Int,
			d : Bool,
			e : Bool,
			f : Bool
		in {
			a <- ~in_int();
			b <- in_int();
			out_int(a);
			out_int(b);
			out_int(c);

			d <- not true;
			e <- not false;
			f <- true;

			if (d < e) then {
				out_int(a);
			} else {
				out_int(c);
			} fi;

			if (d < f) then {
				out_int(a);
			} else {
				out_int(c);
			} fi;
		}
	};
};