-- Test the return type of while loop
class Main inherits Object {

	main() : Object {
		let
			obj : Object,
			x : Int <- 0
		in
			obj <- while x < 10 loop
				x <- x + 1
			pool
	};
};