class Main inherits IO {
	int : IO;
	main() : Object {
		-- Check that the least upper bound is handled correctly
		int <-
			case self of
				x :
					Int
					=> new IO;
				x :
					String
					=> new Main;
				y :
					Main
					=> self;
			esac
	};
};