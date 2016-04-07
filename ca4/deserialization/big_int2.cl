class Main inherits IO {

	main() : Object {
		let
			a : Int <- in_int(),
			b : Int <- in_int(),
			c : Int <- in_int(),
			d : Int <- in_int(),
			e : Int <- in_int(),
			f : Int <- in_int(),
			g : Int <- in_int(),
			h : Int <- in_int(),
			i : Int <- in_int(),
			j : Int <- in_int(),
			k : Int <- in_int(),
			l : Int <- in_int(),
			m : Int <- in_int(),
			n : Int <- in_int(),
			o : Int <- in_int(),
			p : Int <- in_int(),
			q : Int <- in_int(),
			r : Int <- in_int(),
			s : Int <- in_int(),
			t : Int <- in_int(),
			u : Int <- in_int(),
			v : Int <- in_int(),
			w : Int <- in_int(),
			x : Int <- in_int(),
			y : Int <- in_int(),
			z : Int <- in_int(),
			aa : Int <- in_int(),
			ab : Int <- in_int()
		in {
			a <- a + a;
			out_int(a);
			a <- a + b;
			out_int(a);
			a <- a + c;
			out_int(a);
			a <- a + d;
			out_int(a);

			a <- a - a;
			out_int(a);
			a <- a - b;
			out_int(a);
			a <- a - c;
			out_int(a);
			a <- a - d;
			out_int(a);

			a <- a * a;
			out_int(a);
			a <- a * b;
			out_int(a);
			a <- a * c;
			out_int(a);
			a <- a * d;
			out_int(a);	

			a <- a / a;
			out_int(a);
			a <- a / b;
			out_int(a);
			a <- a / c;
			out_int(a);
			a <- a / d;
			out_int(a);

			a <- 2 * a;
			out_int(a);
			a <- 3 + b;
			out_int(a);
			a <- 4 + c;
			out_int(a);
			a <- 5 + d;
			out_int(a);

			a <- 6 - a;
			out_int(a);
			a <- 7 - b;
			out_int(a);
			a <- 8 - c;
			out_int(a);
			a <- 9 - d;
			out_int(a);

			a <- 10 * a;
			out_int(a);
			a <- 11 * b;
			out_int(a);
			a <- 12 * c;
			out_int(a);
			a <- 13 * d;
			out_int(a);	

			a <- 14 / a;
			out_int(a);
			a <- 15 / b;
			out_int(a);
			a <- 16 / c;
			out_int(a);
			a <- 17 / d;
			out_int(a);

			a <- a + b + c + d + e + f + g + h + i + j + k + l + m + n + o + p + q + r + s + t + u + v + w + x + y + z + aa+ ab;
			out_int(a);
		}
	};
};