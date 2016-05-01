class Main inherits IO {
	main() : Object {
		let a : String <- in_string() in {
			out_int(a.length());
			out_string(a.concat("yes"));
		}
	};
};