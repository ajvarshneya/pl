class Main inherits IO {
	main() : Object {
		{
			out_string(777.type_name());
			out_string("\n");
			out_string("cool".type_name());
			out_string("\n");
			out_string(false.type_name());
			out_string("\n");
			out_string((new IO).type_name());
			out_string("\n");
			out_string(type_name());
			out_string("\n");
			out_string((new SELF_TYPE).type_name());
			out_string("\n");

			out_string("----\n");
			out_string((new A).type_name());
			out_string("\n");
			out_string((new B).type_name());
			out_string("\n");
			out_string((new C).type_name());
			out_string("\n");

		}
	};
};

class A {

	get_type_name() : String {
		type_name()
	};

};

class B inherits A {};

class C inherits B {};