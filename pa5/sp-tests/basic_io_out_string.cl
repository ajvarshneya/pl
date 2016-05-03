class Main inherits IO {
	main() : Object {
		{
			out_string("hello cool\n");
			out_string("more strings\n");
			out_string("string with\ttabs\n");
			out_string("backslashes: \\\n");

			-- chain out_string commands
			out_string("1\n").out_string("2\n").out_string("3\n");
		}
	};
};