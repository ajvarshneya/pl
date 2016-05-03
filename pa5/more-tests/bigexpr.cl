class Main inherits IO {
	main () : Object { 
		{
			case (out_string(out_int(self.arith()).do(
				let a : String <- "hello world",
					b : String <- new String,
					c : String <- a.concat(b),
					count : Int <- new Int in {
						if not isvoid (
						while (count < (new Main).arith()) loop {
							count <- count + 9001;
							out_int(count);
						} pool) then out_string ("its not void") else out_string ("it's not not void") fi;
						b;
					}
			).type_name().concat("here is some more garabge").substr(0, 9).copy())) of
			a : Int => out_int(a);
			b : Main => out_int(b.do("plz").do("break").do("my").do("code").arith());
			c : String => out_string (c);
			d : Bool => if (((d < cmp()) <= self.cmp()) = self@Main.cmp()) then out_string ("yes") else out_string ("no") fi;
			esac;
			abort();
		}
	};

	cmp () : Bool {
		(1 < 2) <= (3 = 4)
	};

	arith () : Int {
		~555 * 444 + 333 - 222 / 111
	};

	do (x : String) : SELF_TYPE {
		out_string(x)
	};
};