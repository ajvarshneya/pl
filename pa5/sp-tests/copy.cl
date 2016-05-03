-- tests shallow copy of objects
class Main inherits IO {
	main() : Object {
		let
			a1 : A <- new A,
			a2 : A,
			aw1 : AWrapper <- new AWrapper,
			aw2 : AWrapper
		in {
			-- a2 <- a1.copy();
			-- out_int(a1.get_x());		-- 123
			-- out_string("\n");
			-- out_int(a2.get_x()); 		-- 123
			-- out_string("\n");

			-- -- test shallow copy
			-- a1.set_x(777);
			-- out_int(a1.get_x()); 		-- 777
			-- out_string("\n");
			-- out_int(a2.get_x()); 		-- 123
			-- out_string("\n");

			-- out_string("----\n");
		
			-- -- aw2 is a wrapper around class A,
			-- -- so changes to attrs of A are shared
			-- aw2 <- aw1.copy();
			-- out_int(aw1.get_x()); 		-- 123
			-- out_string("\n");
			-- out_int(aw2.get_x()); 		-- 123
			-- out_string("\n");

			aw2 <- aw1.copy();
			aw1.set_x(9001);
			out_int(aw1.get_x()); 		-- 9001
			out_string("\n");
			out_int(aw2.get_x());		-- 9001
			out_string("\n");
		}
	};
};

class A {
	x : Int <- 123;

	get_x() : Int {
		x
	};

	set_x(val : Int) : Int {
		x <- val
	};
};

class AWrapper {
	a : A <- new A;

	get_x() : Int {
		a.get_x()
	};

	set_x(val : Int) : Int {
		a.set_x(val)
	};
};