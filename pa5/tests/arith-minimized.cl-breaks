(*
 *  A contribution from Anne Sheets (sheets@cory)
 *
 *  Tests the arithmetic operations and various other things
 *)

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
        out_string ("????");
        while flag loop
        {
          -- out_string("hello");
	       char <- in_string();
         out_string (char);
         if char = "q" then flag <- false else 1 fi;
       } pool;
   }
 };

};

