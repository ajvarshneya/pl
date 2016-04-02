class Main inherits IO {
	main() : Object {
		let a : Int in {
			a <- 1;
			if (a < 2) then {
				a <- 123;
			} else {
				a <- 456;
			};
			out_int(a);
		}
	};
};