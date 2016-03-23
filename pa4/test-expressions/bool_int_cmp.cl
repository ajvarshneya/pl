class Main inherits IO {
	main() : Object {
		{
			let a : Bool <- true,
				b : Int <- 0 in {
					a <- a < b;
			};
		}
	};
};