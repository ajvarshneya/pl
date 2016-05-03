class Main inherits IO {
	main() : Object {
		let a : Bool <- true in {
			if (let a : Bool in a) then {
				out_string("yes");
			} else {
				out_string("no");
			} fi;
		}
	};
};