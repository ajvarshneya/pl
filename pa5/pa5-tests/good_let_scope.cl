class Main inherits A {
	main() : Object {
		{
			out_int(x);
			let
				x : Int <- y
			in {
				let
					x : Int <- x,
					z : Int <- 777
				in {
					out_int(x);
					out_int(y);
					out_int(z);
					let
						x : String <- "cool"
					in
						out_string(x)
					;
				};
				out_int(x);
				out_int(y);
			};

			let
				x : String,
				y : Bool
			in {
				if y then out_int(1) else out_int(1) fi;
				out_int(x.length());
				out_string(x.substr(0, 0));
			};

			some_method(123);
		}
	};

	some_method(x : Int) : SELF_TYPE {
		{
			out_int(x);
			out_int(y);
			let
				y : String <- "hello"
			in {
				out_int(x);
				out_string(y);
			};
		}
	};
};

class A inherits IO {
	x : Int <- 777;
	y : Int <- 888;
};