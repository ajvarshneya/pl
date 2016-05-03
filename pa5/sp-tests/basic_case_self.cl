class Main inherits A {
	main() : Object {
		some_method()
	};
};

class A inherits IO {
	some_method() : Object {
		-- case C
		case self of
			a : A => out_string("case A\n");
			m : Main => out_string("case Main\n");
		esac
	};
};