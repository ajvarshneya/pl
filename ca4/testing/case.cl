class A inherits Main {};
class B inherits A {};
class C inherits B {};
class D inherits C {};
class F {};
class G {};

class Main inherits IO {
	a : F <- new F;
	main() : Object {
		let a : Object <- new Object in {
			case self of 
				a : A => {
					let a : Object <- new D in {
						out_string("a");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : B => {
					let a : Object <- new D in {
						out_string("b");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : C => {
					let a : Object <- new D in {
						out_string("c");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : D => {
					let a : Object <- new D in {
						out_string("d");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : Int => {
					let a : Object <- new D in {
						out_string("int");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : Bool => {
					let a : Object <- new D in {
						out_string("bool");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : String => {
					let a : Object <- new D in {
					out_string("string");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : IO => {
					let a : Object <- new D in {
						out_string("IO");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
				a : Main => {
					let a : Object <- new G in {
						out_string("main");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							-- fail here, no G case
						esac;
					};
				};
				a : Object => {
					let a : Object <- new D in {
						out_string("object");
						case a of 
							a : A => {
								out_string("a");
							};
							a : B => {
								out_string("b");
							};
							a : C => {
								out_string("c");
							};
							a : D => {
								out_string("d");
							};
							a : Int => {
								out_string("int");
							};
							a : Bool => {
								out_string("bool");
							};
							a : String => {
								out_string("string");
							};
							a : IO => {
								out_string("IO");
							};
							a : Main => {
								out_string("main");
							};
							a : Object => {
								out_string("object");
							};
						esac;
					};
				};
			esac;
		}
	};
};