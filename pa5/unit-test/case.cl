class A {};
class B inherits A {};
class C inherits B {};
class D inherits C {};
class E inherits Object {};
class F inherits IO {};
class G inherits E {};
class H inherits F {};
class I inherits Main {};

class Main inherits IO {
	a0 : A <- new A;
	b0 : B <- new B;
	c0 : C <- new C;
	d0 : D <- new D;
	e0 : E <- new E;
	f0 : F <- new F;
	g0 : G <- new G;
	h0 : H <- new H;
	i0 : I <- new I;
	a1 : A <- a0;
	a2 : A <- b0;
	a3 : A <- c0;
	a4 : A <- d0;

	main () : Object {
		{
			case_check(a0);
			case_check(b0);
			case_check(c0);
			case_check(d0);
			case_check(c0);
			case_check(d0);
			case_check(e0);
			case_check(f0);
			case_check(g0);
			case_check(h0);
			case_check(i0);
			case_check(a1);
			case_check(a2);
			case_check(a3);
			case_check(a4);
			case_check(new Main);
			case_check(new IO);
			case_check(new String);
			case_check(new Int);
			case_check(new Bool);
		}
	};

	case_check (case_expr : Object) : Object {
		case case_expr of 
			x : A => out_string("A");
			x : IO => out_string("IO");
			x : B => out_string("B");
			x : Object => out_string("Object");
			x : C => out_string("C");
			x : Main => out_string("Main");
			x : D => out_string("D");
			x : String => out_string ("String");
			x : Int => out_string("Int");
			x : Bool => out_string("Bool");
		esac
	};
};