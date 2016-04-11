class Main {
	main() : Object {
		let a : Bool,
			b : Bool in {
			b <- not a;
			a <- not b;
			a <- not a;
		}
	};
};