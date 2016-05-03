class Main inherits IO {
	main() : Object {
		{
			out_int(777);
			out_int(~1);
			out_int(9001);

			-- test method chaining
			out_int(1).out_int(2).out_int(3);
		}
	};
};