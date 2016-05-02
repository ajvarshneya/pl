(* test 1000+ new objects
 * 
 * Note: This is NOT trying to heap overflow, but rather just checking that stack
 *	overflow checks for *outstanding* new records, not total new records
 *)
class Main inherits IO {
	main() : Object {
		let
			x : Int,
			chain : Chain <- new Chain
		in
			while x < 1100 loop {
				chain <- chain.prepend(new Chain);
				x <- x + 1;
			}
			pool
	};
};

class Chain {
	next : Chain;

	prepend(c : Chain) : Chain {
			c.set_next(self)
	};

	set_next(c : Chain) : Chain {
		{
			next <- c;
			self;
		}
	};
};