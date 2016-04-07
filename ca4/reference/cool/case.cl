class Main inherits IO {
	main() : Object {
		let a : Int in {
			case a of 
				x : Int => x;
				x : Object => x;
			esac;
		}
	};
};