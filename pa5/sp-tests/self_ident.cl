class Main inherits IO {
	main() : Object {
		{
			self;
			self.out_string("hello cool\n");
			self.out_int(777);
			self.out_string("\n");

			let
				s : Main <- self
			in {
				s.out_string("test self assign\n");
				s.out_int(s.some_method());
				s.out_string("\n");
			};
		}
	};

	some_method() : Int {
		9001
	};
};