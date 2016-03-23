class B {
	c (e : Int) : Int {
		1
	};
};

class Main inherits IO {
    a : Int <- 1;

    b (a : Int) : Int {
    	1
    };

    main () : Object {
    	(new B).c(4)
    };
};