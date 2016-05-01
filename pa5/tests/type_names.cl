class A inherits Main {
	main() : Object {
		out_string((new SELF_TYPE).type_name())
	};
};

class Main inherits IO {
	main() : Object {
		(new A).main()
	};
};