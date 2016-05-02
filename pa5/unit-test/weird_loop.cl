class A {};

class Main inherits IO {

	char : String;
	avar : A; 
	flag : Bool <- true;

	menu() : String {
		{
			out_string("hello");
			in_string();
		}
	};

	main() : Object {
		{
			avar <- (new A);
			while flag loop
			{
				char <- in_string();
				out_string (char);
				if char = "q" then flag <- false else 1 fi;
			} pool;
		}
	};
};

