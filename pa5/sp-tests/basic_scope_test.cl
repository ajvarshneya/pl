class Main {
	a : Int <- 1000;

	main() : Object {
		{
			let
				a : Int <- 2000
			in {
				some_method(a); -- 2000
			};
			a; -- 1000
		}
	};

	some_method(a : Int) : Object {
		{
			let
				a : Int <- 3000
			in
				a + 777 -- 3777
			;

			a; -- 2000
		}
	};
};
