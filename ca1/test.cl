class Main inherits IO {

   method2(num1 : Int, num2 : Int) : Int {  -- plus
      (let x : Int in
	 {
            x <- num1 + num2;
	 }
      )
   };

  main() : Object { 
  	let x : Int <- in_int()
  	in 
  	let var : Bool <- (not (x < 10)) 
  	in {
  		if var then {
  			out_string("The number is less than 10");
  		} else {
  			out_string("The number is no less than 10.");
  		}
  		fi;

  		if (isvoid x) then {
  			out_string("plz work");
  		} else {
  			let y : String <- in_string()
  			in
  				out_string(y);
  		}
  		fi;
  		out_string("ok");
  	}
  };
}; 

class Cons inherits List {

   car : Int;	-- The element in this list cell

   cdr : List;	-- The rest of the list

   isNil() : Bool { false };

   head()  : Int { car };

   tail()  : List { cdr };

   init(i : Int, rest : List) : List {
      {
	 car <- i;
	 cdr <- rest;
	 self;
      }
   };

};