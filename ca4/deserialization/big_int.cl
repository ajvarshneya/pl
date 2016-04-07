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
			out_int(a);
			b <- c - d;
			out_int(b);
			c <- d * e;
			out_int(c);

			d <- e / f;
			out_int(d);

			d <- 12324509 / f;
			out_int(d);

			e <- (e + e);
			out_int(e);
			f <- f + (f * 0);
			out_int(f);
			g <- (h - 0) * j;
			out_int(g);
			h <- (i + j) / k; 
			out_int(h);

			e <- (111 + e);
			out_int(e);
			f <- 222 + (444 * 0);
			out_int(f);
			g <- (h - 0) * 333;
			out_int(g);
			h <- (i + j) / 2; 
			out_int(h);

			i <- ~0 + (0 + l);
			out_int(i);
			j <- (k + l) - m;
			out_int(j);
			k <- ~l + (m * n);
			out_int(k);
			l <- (m + n) / o;
			out_int(l);

			m <- n - ~o + p;
			out_int(m);
			n <- o - p - q;
			out_int(n);
			o <- 0 - ~0 * r;
			out_int(o);
			p <- q - ~r / s;
			out_int(p);

			q <- r / (s + t);
			out_int(q);
			r <- (s * t) - u;
			out_int(r);
			s <- t * (u * v);
			out_int(s);
			t <- u * v / w;
			out_int(t);

			u <- a / w + x;
			out_int(u);
			w <- b / a * b;
			out_int(w);

			x <- x / 4;
			out_int(x);
			x <- 123 / x;

			-- u <- v / w + x;
			out_int(u);
			w <- x / a * b;
			out_int(w);

			x <- x / 4;
			out_int(x);
			x <- 123 / x;
			out_int(x);

			a <- 12 / 4;
			out_int(a);

			b <- 3 / 12;
			out_int(b);

			a <- (a * a) / (3 + 2) / a - 6 + 1234 - (2 * 3) + (a * a) / a;
			out_int(a); 
		}
	};
};