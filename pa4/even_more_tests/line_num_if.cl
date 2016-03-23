-- Check line number of error in if
class Main inherits IO {

	main() : Object {
		if
			true
		then
			~"str"
		else
			77
		fi
	};
};