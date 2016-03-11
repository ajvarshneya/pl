-- Program to read two numbers and output the min
class Main inherits IO {

	main() : Object {
		let
			x : Int,
			y : Int
		in {
			x <- in_int();
			y <- in_int();

			if x < y then
				out_int(x)
			else
				out_int(y)
			fi;
		}
	};
};