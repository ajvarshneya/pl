class Main inherits IO {
	x : Int <- 9001;
	y : Int;

	main() : Object {
		{
			let
				a : String <- "hello"
			in {
				-- dispatch
				some_method({
					a <- "cool";
					x <- 777;
					y;
				});
				out_string(a);
			};
			out_int(x);
			out_int(y);
		}
	};

	some_method(param : Int) : Object {
		out_int(param)
	};
};