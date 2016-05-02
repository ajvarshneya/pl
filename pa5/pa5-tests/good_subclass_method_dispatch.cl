class Main inherits IO {
	main() : Object {
		let
			a : A <- new B
		in {
			out_string(a.type_name());
			out_string("\n");
			out_string(a.some_method("cool"));
			out_string(a@A.some_method("stuff"));
			out_string(a.another_method().type_name());
			out_string("\n");
			out_string(a@A.another_method().type_name());
			out_string("\n");
		}
	};
};

class A inherits IO {

	some_method(param : String) : String {
		{
			out_string(param);
			param.concat("\n");
		}
	};

	another_method() : SELF_TYPE {
		new SELF_TYPE
	};
};

class B inherits A {

	some_method(s : String) : String {
		{
			out_int(7777);
			s.concat("\n");
		}
	};
};