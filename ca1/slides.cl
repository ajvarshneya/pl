class Main inherits IO {
	main(): Object {
		let a : Int,
			b : Int,
			c : Int in {
				a <- 1;
				b <- in_int();
				c <- a + 3;
				if (a < b) then {
					out_int(c + 6);
				} else {
					out_int(a);
				}
				fi;
				out_int(b);
			}
	};
};