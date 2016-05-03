class Main {
	main() : Object {
		let
			x : Int <- 123,
			a : Object <- 2,
			b : Object <- 3,
			io : IO <- new IO,
			void : Object
		in {
			-- compare ints
			5 <= 7;				-- 1
			9001 <= 777;		-- 0
			444 <= 444; 		-- 1

			-- compare strings
			"abc" <= "edf";		-- 1
			"zzz" <= "abc";		-- 0
			"cool" <= "cool"; 	-- 1

			-- compare bools
			false <= true;		-- 1
			true <= false;		-- 0
			true <= true; 		-- 1

			-- compare different types
			a <= io; 			-- 0

			-- compare dynamic ints
			a <= b;				-- 1
			b <= a;				-- 0

			-- compare same ptr
			a <= a;				-- 1

			-- compare void
			a <= void;			-- 0
			void <= a;			-- 0
			void <= void;		-- 1
		}
	};
};