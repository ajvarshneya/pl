class Main inherits IO {

	main() : Object {
		let
			x : Int
		in {
			x <- in_int();
			out_int(x);
			x <- in_int();
			out_int(x);
		}
	};

};