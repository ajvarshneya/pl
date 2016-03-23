class Toaster {
    toast(bread : Bread) : Bread {
        if not bread.is_toasted() then {
            bread.toast();
        } else {
            (new Toast).init(bread).burn();
        } fi
    };
};

class Bread {
    toasted : Bool <- false;
    spread : Spread;

    -- Just loafin' around
    loaf() : SELF_TYPE {
        self
    };

    toast() : SELF_TYPE {
        {
            toasted <- true;
            self;
        }
    };

    spread(s : Spread) : SELF_TYPE {
        {
            if isvoid spread then {
                spread <- s;
            } else {
                abort();
            } fi;

            self;
        }
    };

    -- jam AND mystery spread? you monster
    force_spread(s : Spread) : SELF_TYPE {
        {
            spread <- s;
            self;
        }
    };

    ew_what_is_that() : Spread {
        spread
    };

    is_toasted() : Bool {
        toasted
    };

    is_buttered() : Bool {
        if spread.type_name() = "Butter" then {
            true;
        } else {
            false;
        } fi
    };
};

class Toast inherits Bread {
    
    burned : Bool <- false;

    burn() : SELF_TYPE {
        {
            if not toasted then abort() else {
                burned <- true;
            } fi;
            self;
        }
    };

    init(bread : Bread) : SELF_TYPE {
        {
            toasted <- bread.is_toasted();
            spread <- bread.ew_what_is_that();
            self;
        }
    };
};

class Spread {
    delicious : Bool <- true;

    is_delicious() : Bool {
        delicious
    };

    to_string() : String {
        self.type_name()
    };
};

-- I can't believe it's not butter!
class MysterySpread inherits Spread {
    get_spread() : SELF_TYPE {
        new MysterySpread
    };
};

class Jam inherits Spread {};

class RaspberryJam inherits Jam {};

class Butter inherits Spread {};

class Main inherits IO {
    main () : Object {
        let toaster : Toaster <- new Toaster,
            bread : Bread <- new Bread,
            s : String in {
            bread <- toaster@Toaster.toast(bread);
            bread <- bread.spread(new RaspberryJam);
            s <- "This bread is ";
            if bread.is_toasted() then {
                self;
            } else {
                s <- s.concat("not ");
            } fi;
            s <- s.concat("toasted and has ").concat(bread.ew_what_is_that().to_string()).concat("!\n");
            out_string(s);

            -- This makes it break
            bread <- bread.force_spread(new MysterySpread);
            bread_spread_identity <- bread.ew_what_is_that().get_spread();
        }
    };
};