class Main inherits IO {
	main() : Object {
		{
			if true then
				out_string("then-branch\n")
			else
				out_string("else-branch\n")
			fi;

			if false then
				out_string("then-branch\n")
			else
				out_string("else-branch\n")
			fi;

			if (5 + 777 < 9001) then
				out_string("then-branch\n")
			else
				out_string("else-branch\n")
			fi;

			if true then {
				out_string("then-branch\n");
				out_string("more output\n");
			}
			else
				out_string("else-branch\n")
			fi;
		}
	};
};