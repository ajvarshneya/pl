class Main inherits IO {

	main() : Object {
		method(
			5,		-- arg 1
			7		-- arg 2 - error here
		)
	};

	method(int : Int, str : String) : Object {
		5
	};

};