class Main inherits IO {
	main() : Object {
		{
			let a : String <- "abc",
				b : String <- "xyz" in {
					a <- a < b;
			};
		}
	};
};