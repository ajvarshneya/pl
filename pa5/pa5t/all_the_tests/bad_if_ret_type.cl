-- Bad return type from else statement (Int u String != Int)
class Main inherits IO {

	main() : Object {
		0
	};

	test_method() : Int {
		if true then
			5
		else
			"string"
		fi
	};

};