class Main inherits IO {

	x : Int <- 777;
	me : SELF_TYPE <- copy();

	main() : Object {
		{
			me.out_string("hello cool\n");
			out_int(me.getX());
			out_int(x);
		}
	};

	getX() : Int {
		x
	};
};