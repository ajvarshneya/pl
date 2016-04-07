class Main inherits IO {

	main() : Object {
		let
			a : Int,
			b : Int,
			c : Bool
		in {
			a <- 7;
			b <- 3;

			if a < b then
				out_int(1)
			else
				out_int(0)
			fi;
			if a <= b then
				out_int(1)
			else
				out_int(0)
			fi;
			if a = b then
				out_int(1)
			else
				out_int(0)
			fi;
		}
	};

};