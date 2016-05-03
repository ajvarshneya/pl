class Main inherits IO {
	main() : Object {
		let
			obj : Object
		in {
			case
				obj
				of
				i : Int => out_string("here");
				o : Object => out_string("object");
			esac;
		}
	};
};