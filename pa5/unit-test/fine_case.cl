class A {};

class B inherits A {};

class Main inherits IO {
	main() : Object {
		let a : A <- new A,
			b : A <- new B,
			c : B <- new B in {
			case a of
				x : String => out_string("abcdef");
				y : A => out_string("182319283");
				z : B => out_string("jdfjwu4");
			esac;
			case b of
				x : String => out_string("abcdef");
				y : A => out_string("182319283");
				z : B => out_string("jdfjwu4");
			esac;
			case c of
				x : String => out_string("abcdef");
				y : A => out_string("182319283");
				z : B => out_string("jdfjwu4");
			esac;
		}
	};
};