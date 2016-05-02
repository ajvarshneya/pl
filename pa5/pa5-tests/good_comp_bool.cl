class Main inherits IO {
	main() : Object {
		let
			x : Bool,
			y : Bool <- true
		in {
			if x < y then
				out_string("x < y\n")
			else
				out_string("x !< y\n")
			fi;
		}
	};
};