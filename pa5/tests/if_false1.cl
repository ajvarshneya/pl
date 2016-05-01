class Main inherits IO {
	main() : Object {
		let a : Int in {
			a <- 1;
			if (2 < a) then {
				a <- 123;
			} else {
				a <- 456;
			} fi;
			out_int(a);
		}
	};
};