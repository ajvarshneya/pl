class Main inherits IO {
	main() : Object {
		{
			let a : Bool <- true,
				b : Bool <- false in {
					a <- a < b;
			};
		}
	};
};