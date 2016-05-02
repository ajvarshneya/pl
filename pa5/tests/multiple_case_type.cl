class Main inherits IO {
	main() : Object {
		{
			let a : Int,
				b : Int,
				c : Int,
				d : A in {
					case d of
						a : String => 1;
						b : Int => 2;
						d : Int => 3;
					esac; 
			};
		}
	};
};

class A {
	a : Int;
};