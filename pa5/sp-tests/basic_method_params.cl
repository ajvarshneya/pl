class Main {
	main() : Object {
		let
			a : Int <- 1,
			b : Int <- 2
		in {
			some_method(a, b);
			b;
		}
	};

	some_method(a : Int, b : Int) : Int {
		{
			a + 3;
			b <- 9001;
		}
	};
};