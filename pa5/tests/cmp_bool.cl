class Main inherits IO {
	main() : Object {
		let a : Bool,
			b : Bool <- true in {
				if (a < b) then out_string("yes\n") else out_string("no\n") fi;
		}
	};
};