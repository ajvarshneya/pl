class Main inherits IO {
	main () : Object {
		let a : Int,
			b : Int,
			c : Bool in {
				a <- 3;
				a <- 4;
				b <- 123123;
				c <- true;
				out_int(a);

				while (a < 22) loop {
					a <- a + 1;
				} pool;

				if (22 < a) then {
					out_int(b);
				} else {
					self;
				} fi;
		}
	};
};
