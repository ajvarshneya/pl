class Main inherits IO  {

	main() : Object {
		let
			str : String
		in {
			-- Good method calls
			str.length();
			str.concat("abc");
			str.substr(0, 2);

			-- Bad method calls (wrong number of args)
			str.length(str);
			str.concat("abc", "abc");
			str.substr(0);
		}
	};
};