class Main inherits IO {
	i : Int <- 777;
	obj : Object;
	s : SELF_TYPE <- self;

	main() : Object {
		{
			out_int(i);
			s.out_int(i);
		}
	};
};