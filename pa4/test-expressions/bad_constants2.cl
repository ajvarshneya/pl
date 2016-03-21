class B {
	a : Int;
};

class A inherits B {
	b : Int;
};

class Main inherits IO {
    a : A <- new B;

    main () : Object {
        1
    };
};