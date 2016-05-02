class Main inherits IO {
	main() : Object {
		let
			int : Int
		in {
			-- input: 777abc (input partially contains strings)
			-- int set to 0 since input is out of bounds
			int <- in_int();
			out_int(int);
			out_string("\n");
		}
	};
};