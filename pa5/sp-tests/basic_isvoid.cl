class Main inherits IO {
	main() : Object {
		let
			b : Bool,
			i : Int,
			s : String,
			io : IO,
			obj : Object
		in {
			-- check default values
			if isvoid b then out_string("b is void\n") else out_string("b is NOT void\n") fi;
			if isvoid i then out_string("i is void\n") else out_string("i is NOT void\n") fi;
			if isvoid s then out_string("s is void\n") else out_string("s is NOT void\n") fi;
			if isvoid io then out_string("io is void\n") else out_string("io is NOT void\n") fi;
			if isvoid obj then out_string("obj is void\n") else out_string("obj is NOT void\n") fi;
			out_string("\n");

			-- -- check after assigning
			io <- new IO;
			if isvoid io then out_string("io is void\n") else out_string("io is NOT void\n") fi;

		}
	};
};