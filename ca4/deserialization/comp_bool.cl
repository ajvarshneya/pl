class Main inherits IO {

	main() : Object {
		let
			a : Bool,
			b : Bool
		in {
			a <- true;
			if a <= b then
				out_int(1)
			else
				out_int(0)
			fi;

			a <- not b;
			if a = b then
				out_int(1)
			else
				out_int(0)
			fi;

			a <- false;
			b <- true;
			if a < b then
				out_int(1)
			else
				out_int(0)
			fi;
		}
	};
};