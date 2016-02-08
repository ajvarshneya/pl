Class Main inherits IO {
	sorted_list : Int <- new Int;
	cycle : Bool <- false;

	main() : Object { 
		{
			-- Construct graph from input
			let done : Bool <- false 
			in {
				while not done loop {
					let dst : String <- in_string()
					in {
						if dst = "" then
							done <- true
						else {
							
							let src : String <- in_string()
							in {
								out_string(src);
							};
						}
						fi;
					};
				} pool;
			};
			if not cycle then
				out_int(1)
			else
				out_string("")
			fi;
		}
	};
};
