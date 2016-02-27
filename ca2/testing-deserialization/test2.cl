class Main inherits IO {
  main() : Object { 
    let a : Int <- (1 + 2 + 3 * 4),
    	b : B <- new B in {
		out_string("plz");
		self.out_string("maybe");
		self@IO.out_string("yes");

		c : Int <- 3;
		d : Int <- 4;
		if (c < d) then {
			out_string("c less than d");
		} else {
			out_string("c not less than d");
		};
		
    }
  };
} ; 

class B inherits IO {
	a : Int;
};