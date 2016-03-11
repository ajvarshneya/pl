-- Tests overlow for integers as input
-- NOTE: Input a value > 2147483647 or < -2147483648
class Main inherits IO {

	main() : Object {
		let
			a : Int
		in {
			a <- in_int();
			out_int(a);
		}
	};
};