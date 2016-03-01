class Main inherits IO {
  main() : Object { 
    let a : Int <- (1 + 2 + 3 * 4),
    	b : B <- new B in {
		out_string("plz");
		self.out_string("maybe");
		self@IO.out_string("yes");

		case a of
			a : Int => a <- 3;
			b : B => a <- 4;
		esac;
    }
  };
} ; 

class B inherits IO {
	a : Int;
};