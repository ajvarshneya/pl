-- Check line number of error in assign
class Main inherits IO {

	main() : Object {
		let
			x : Int
		in
			x
			<-
			"cool string"
	};
};