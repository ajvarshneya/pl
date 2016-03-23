class Main {
	main() : Object {
		let
			int : Int,
			m : Main
		in
			m <- some_method(
				int)
	};

	some_method(x : Int) : SELF_TYPE {
		self
	};
};