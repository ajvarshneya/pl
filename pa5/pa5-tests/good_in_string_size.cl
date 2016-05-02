class Main inherits IO {
	main() : Object {
		let
			str : String <- in_string()
		in {
			out_string(str);
			out_int(str.length());
			out_string(str.concat("cool\n"));
			out_string(str.substr(0, 1500));
			out_string("\n");
		}
	};
};