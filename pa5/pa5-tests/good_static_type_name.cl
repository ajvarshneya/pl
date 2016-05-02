class Main inherits IO {
	main() : Object {
		let
			a : A <- new A,
			b : B <- new B
		in {
			out_string(a@A.type_name());
			out_string("\n");
			out_string(b@A.type_name());
			out_string("\n");
			out_string(b@B.type_name());
			out_string("\n");
			out_string(a@Object.type_name());
			out_string("\n");
			out_string(b@Object.type_name());
			out_string("\n");
		}
	};
};

class A {

};

class B inherits A {

};