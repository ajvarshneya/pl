class Main inherits IO {
	a : Int <- 0;
	main() : Object {
		{	
			a <- a + 1;
			self.
			out_int(
				a
				);
			out_string("\n");
			main () ;
		}
	};
};