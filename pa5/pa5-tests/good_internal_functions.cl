class Main inherits IO {
	main() : Object {
		let
			str : String <- "cool",
			obj : Object
		in {
			out_string((new Object).type_name());
			out_string(str.type_name());

			(self.copy()).out_string(str.copy());

			self.out_string("test");

			out_int(str.length());
			out_string("hello ".concat(str));
			out_string("a string with many words".substr(0, 8));

			out_string(1.type_name());
			out_string("test".type_name());
		}
	};
};