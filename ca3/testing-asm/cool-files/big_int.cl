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
			x : Int <- in_int()
		in {
			a <- a + c;
			b <- c - d;
			c <- d * e;
			d <- e / f;

			e <- (e + e);
			f <- f + (f * 0);
			g <- (h - 0) * j;
			h <- (i + j) / k; 


			i <- ~0 + (0 + l);
			j <- (k + l) - m;
			k <- ~l + (m * n);
			l <- (m + n) / o;

			m <- n - ~o + p;
			n <- o - p - q;
			o <- 0 - ~0 * r;
			p <- q - ~r / s;

			q <- r * (s + t);
			r <- (s * t) - u;
			s <- t * (u * v);
			t <- u * v / w;

			u <- v / w + x;
			w <- x / a * b;

			x <- x / 4;
			x <- 123 / x;

			a <- 12 / 4;

			b <- 3 / 12;

			out_int(a);
			out_int(b);
			out_int(c);
			out_int(d);
			out_int(e);
			out_int(f);
			out_int(g);
			out_int(h);
			out_int(i);
			out_int(j);
			out_int(k);
			out_int(l);
			out_int(m);
			out_int(n);
			out_int(o);
			out_int(p);
			out_int(q);
			out_int(r);
			out_int(s);
			out_int(t);
			out_int(u);
			out_int(v);
			out_int(w);
			out_int(x);
		}
	};
};