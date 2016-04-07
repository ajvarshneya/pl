class Main inherits IO {
    main() : Object {
        let 
            a : Int <- in_int(),
            b : Int <- in_int(),
            c : Int <- in_int(),
            d : Int <- in_int(),
            e : Int <- in_int()
        in {
            e <- (a + b) * (a - b) / d;
        }
    };
};