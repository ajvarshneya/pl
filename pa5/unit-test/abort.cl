class Main {
	main () : Object {
		{
			self.abort();
			self@Main.abort();
			self@Object.abort();
			1.abort();
			"".abort();
			(new Main).abort();
			abort();
		}
	};
};