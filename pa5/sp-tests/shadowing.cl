(* SAMPLE OUTPUT:
 * 0
 * 9001
 * abc
 * 4
 * jkl
 * 3
 * ghi
 * 2
 * def
 * 1
 * abc
 *)

class Main inherits A {
	main() : Object {
		{
			let
				i : Int <- 2,
				b : Bool,
				s : String <- "def"
			in {
				let
					i : Int <- 3,
					b : Bool,
					s : String <- "ghi"
				in {
					some_method(9001, true);

					-- values from inner let
					out_int(i);
					out_string("\n");
					out_string(s);
					out_string("\n");
				};

				-- values from initial let
				out_int(i);
				out_string("\n");
				out_string(s);
				out_string("\n");
			};

			-- attributes
			out_int(i);
			out_string("\n");
			out_string(s);
			out_string("\n");
		}
	};

	-- shadow i and b in the method, s refers to the attr
	some_method(i : Int, b : Bool) : Object {
		{
			-- check shadowing in case
			case (new Int) of
				-- shadow i in case
				i : Int => {
					out_int(i);
					out_string("\n");
					i <- 777;
				};
			esac;

			-- check that i is still 9001
			out_int(i);
			out_string("\n");

			-- s = "abc"
			out_string(s);
			out_string("\n");

			-- check param shadowing in let
			let
				i : Int <- 4,
				b : Bool,
				s : String <- "jkl"
			in {
				out_int(i);
				out_string("\n");
				out_string(s);
				out_string("\n");
			};
		}
	};
};

class A inherits IO {
	i : Int <- 1;
	b : Bool <- true;
	s : String <- "abc";
};