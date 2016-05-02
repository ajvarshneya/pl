class Main inherits IO {
	main() : Object {
		let
			x : Int,
			obj : Object
		in {
			obj <-
				while x < 10 loop
					x <- x + 1
				pool;

			if isvoid obj then
				out_string("success\n")
			else
				out_string("failed\n")
			fi;
		}
	};
};