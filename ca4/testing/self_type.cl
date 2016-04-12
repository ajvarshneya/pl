class A inherits Main {
	a() : A {
		(new B)
	};

	me() : SELF_TYPE {
		self
	};

	b() : String {
		"nice ?"
	};
};

class B inherits A {
	a : SELF_TYPE;
	b : Int <- 1;
	me() : SELF_TYPE {
		self
	};
	c() : Int {
		b <- 2
	};
	d() : Int {
		b
	};
};

class Main inherits IO {
	a() : A {
		new A
	};

	b() : String {
		"plz work\n"
	};

	f() : SELF_TYPE {
		self
	};

	main() : Object {
		{
		(new SELF_TYPE).out_string(self.a().f().b());
		(new B)@IO.out_string((new B)@A.a().a().a().me().b());
		out_int((new B).me().d());
		let a : Int <- 123456 in {
			let a : Int <- 123 in {
				let a : Int <- 1 in {
					out_int(a);
					};
				};
			};
		}
	};
};