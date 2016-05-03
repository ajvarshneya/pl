class Main inherits IO {
	main() : Object {
		let a : Int,
			b : Int,
			c : Int,
			d : Int,
			e : Int,
			f : Int,
			g : Int,
			h : Int,
			i : Int,
			j : Int,
			ans : Int in {
			if (a < b) then {
				if (c < d) then {
					ans <- e;
				} else {
					ans <- f;
				} fi;
			} else {
				if (g < h) then {
					ans <- i;
				} else {
					ans <- j;
				} fi;
			} fi;
		}
	};
};