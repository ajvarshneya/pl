class Main inherits IO {
    x : Object;
    y : Object <- new IO; 
    main() : Object {{
        x <- y;
        if x = y then out_int(1) else out_int(0) fi; 
    }}; 
};