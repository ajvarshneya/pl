class Main {
	int : Int;
	main() : Object {
		-- Check that the least upper bound is handled correctly
		int <-
			case int of
				x :
					Int
					=> x + 7;
				x :
					String
					=> 777;
			esac
	};
};