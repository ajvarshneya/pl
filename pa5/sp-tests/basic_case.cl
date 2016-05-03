class Main inherits IO {
	main() : Object {
		let
			a : A <- new D
		in {
			-- case C
			case a of
				a : A => {
					a;
					out_string("case A\n");
				};
				b : B => out_string("case B\n");
				c : C => out_string("case C\n");
				i : Int => out_string("case Int\n");
			esac;

			-- case B
			case a of
				a : A => {
					a;
					out_string("case A\n");
				};
				b : B => out_string("case B\n");
				i : Int => out_string("case Int\n");
			esac;

			a <- new B;

			-- case B
			case a of
				a : A => {
					a;
					out_string("case A\n");
				};
				b : B => out_string("case B\n");
				c : C => out_string("case C\n");
				i : Int => out_string("case Int\n");
				o : Object => out_string("case Object\n");
			esac;
		}
	};
};

class A {
};

class B inherits A {
};

class C inherits B {
};

class D inherits C {
};