class Main inherits IO {
	main() : Object {
		rec(0)
	};

	rec(a : Int) : Object {
		if (a < 1001) then
			rec(a + 1) else self fi
	};
};