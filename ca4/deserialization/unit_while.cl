class Main inherits IO {

	main() : Object {
		let
			x : Int
		in
			while x < 10 loop {
				out_int(x);
				x <- x + 1;
			}
			pool
	};
};