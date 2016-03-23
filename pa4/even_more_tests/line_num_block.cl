-- Check line number of error in block
class Main inherits IO {

	main() : Object {
		{
			5
			+
			7;
			77 - 9001;
			"a" + 5;
		}
	};
};