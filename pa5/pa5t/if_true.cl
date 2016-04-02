class Main inherits IO {
	main() : Object {
		let a : Int in {
			a <- 1;
			if (a < 2) then {
				out_int(1);
			} else {
				out_int(2);
			};
		}
	};
};