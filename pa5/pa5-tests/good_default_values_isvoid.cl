class Main inherits IO {
	main() : Object {
		let
			int : Int,
			str : String,
			bool : Bool,
			obj : Object,
			io : IO,
			main : Main,
			this : SELF_TYPE
		in {
			if isvoid int then out_string("void\n") else out_string("not void\n") fi;
			if isvoid str then out_string("void\n") else out_string("not void\n") fi;
			if isvoid bool then out_string("void\n") else out_string("not void\n") fi;
			if isvoid obj then out_string("void\n") else out_string("not void\n") fi;
			if isvoid io then out_string("void\n") else out_string("not void\n") fi;
			if isvoid main then out_string("void\n") else out_string("not void\n") fi;
			if isvoid this then out_string("void\n") else out_string("not void\n") fi;
		}
	};
};