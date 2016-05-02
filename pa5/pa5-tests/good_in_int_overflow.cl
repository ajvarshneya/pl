class Main inherits IO {
	main() : Object {
		let
			int : Int
		in {
			-- input: 2147483648 (int too large)
			-- int set to 0 since input is out of bounds
			int <- in_int();
			out_int(int);
			out_string("\n");
		}
	};
};