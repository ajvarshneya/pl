class A {};

class B inherits A {};

class C inherits B {};


class Main inherits IO {
	main() : Object {
		let a : A <- new A,
			b : A <- new B,
			c : B <- new B,
			d : C <- new C in {
			case a of
				x : Object => 
				{	
					out_string(x.type_name());
					out_string("102910810");
				};
				x : String => 
				{ 
					out_string(x.type_name());
					out_string("abcdef");
				};
				x : A => 
				{ 
					out_string(x.type_name());
					out_string("182319283");
				};
				x : B => 
				{ 
					out_string(x.type_name());
					out_string("jdfjwu4");
				};
			esac;
			case b of
				x : Object => 
				{ 
					out_string(x.type_name());
					out_string("102910810");
				};
				x : String => 
				{ 
					out_string(x.type_name());
					out_string("abcdef");
				};
				x : A => 
				{ 
					out_string(x.type_name());
					out_string("182319283");
				};
				x : B => 
				{ 
					out_string(x.type_name());
					out_string("jdfjwu4");
				};
			esac;
			case c of
				x : Object => 
				{ 
					out_string(x.type_name());
					out_string("102910810");
				};
				x : String => 
				{ 
					out_string(x.type_name());
					out_string("abcdef");
				};
				x : A => 
				{ 
					out_string(x.type_name());
					out_string("182319283");
				};
				x : B => 
				{ 
					out_string(x.type_name());
					out_string("jdfjwu4");
				};
			esac;
			case d of
				x : Object => 
				{
					out_string(x.type_name());
					out_string("102910810");
				};
				x : String => 
				{
					out_string(x.type_name());
					out_string("abcdef");
				};
				x : A => 
				{
					out_string(x.type_name());
					out_string("182319283");
				};
				x : B => 
				{
					out_string(x.type_name());
					out_string("jdfjwu4");
				};
				x : C => 
				{
					out_string(x.type_name());
					out_string("1209381029381");
				};
			esac;
		}
	};
};