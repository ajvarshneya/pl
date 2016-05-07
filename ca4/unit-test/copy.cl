class Main inherits IO {
	a : String <- "hello, world\n";
	main () : Object {
		{
			out_string(copy().type_name());
			out_string(copy().get_a());
		}
	};

	get_a () : String {
		a
	};
};