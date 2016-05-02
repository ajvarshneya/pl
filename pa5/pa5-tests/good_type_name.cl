class Main inherits IO {
	main() : Object {
		{
			out_string((new Int).type_name());
			out_string((new String).type_name());
			out_string((new Bool).type_name());
			out_string((new IO).type_name());
		}
	};
};