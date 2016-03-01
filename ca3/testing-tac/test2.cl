class Main inherits IO {
  main() : Object { 
    let a : Int <- (1 + 2 + 3 * 4),
    	b : B <- new B in {
		out_string("plz");
		self.out_string("maybe");
		self@IO.out_string("yes");

		let e : Int <- 10,
			c : Int <- 3,
			d : Int <- 4,
			s : String <- "" in {

			if (c < d) then {
				out_string("c less than d");
			} else {
				out_string("c not less than d");
			}
			fi;

			if (c <= d) then {
				out_string("c less than d");
			} else {
				out_string("c not less than d");
			}
			fi;

			while (c < e) loop {
				e <- e - 1;
				out_int(e);
			} pool;

			d <- in_int();
			while (not (d = 10)) loop {
				d <- in_int();
			} pool;

			s <- in_string();
			while (not (s = "stop")) loop {
				s <- in_string();
			} pool;

			out_int(if true then 5 else 7 fi);
		};
    }
  };
} ; 

class B inherits IO {
	a : Int;
};