class Main inherits IO {
	some_attr : Int <- 777;
	another_attr : Int;

	main() : Object {
		{
			out_int(some_attr);
			out_int(9001 + some_attr);
			some_attr <- 123;
			out_int(some_attr);
			out_int(another_attr);

		}
	};
};
