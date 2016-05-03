class Main inherits IO {
	main() : Object {
		let
			i : Int <- 123,
			obj : Object <- 777
		in {
			-- case C
			case obj of
				i : Int => {
						out_int(i);
						out_string("\n");
						i <- 9001;
					};
			esac;
			out_int(i);
			out_string("\n");
		}
	};
};