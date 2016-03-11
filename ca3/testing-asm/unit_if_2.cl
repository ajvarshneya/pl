class Main inherits IO {

	main() : Object {
		let
			a : Int <- 1,
			b : Int <- 2,
			c : Int
		in {
			if true then
				c <- a
			else
				c <- b
			fi;
			a;
			c;
		}
	};
};