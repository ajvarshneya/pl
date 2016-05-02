class Main inherits IO {
	main() : Object {
		{
			let
				a : A <- new A
			in
				case a of
					x : A => out_string("a has type A\n");
					x : B => out_string("a has type B\n");
				esac
			;

			let
				a : A <- new B
			in
				case a of
					x : A => out_string("a has type A\n");
					x : B => out_string("a has type B\n");
				esac
			;

			let
				b : B <- new B
			in
				case b of
					x : A => out_string("b has type A\n");
					x : B => out_string("b has type B\n");
				esac
			;
		}
	};
};

class A {

};

class B inherits A {

};