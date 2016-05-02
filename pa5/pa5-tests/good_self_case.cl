class Main inherits IO {
	main() : Object {
		{
			let
				a : A <- new A
			in
				a.some_method()
			;

			some_method();
		}
	};

	some_method() : Object {
		case self of
			i : Int => out_string("int\n");
			s : String => out_string("stirng\n");
			io : IO => out_string("io\n");
			main : Main => out_string("main\n");
			a : A => out_string("a\n");
		esac
	};
};

class A inherits Main {
};