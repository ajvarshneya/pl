class Main inherits IO {

	main() : Object {
		let
			-- Allocate 26 x 4 registers
			a0 : Int, b0 : Int, c0 : Int, d0 : Int, e0 : Int, f0 : Int, g0 : Int, h0 : Int, i0 : Int, j0 : Int,
			k0 : Int, l0 : Int, m0 : Int, n0 : Int, o0 : Int, p0 : Int, q0 : Int, r0 : Int, s0 : Int, t0 : Int,
			u0 : Int, v0 : Int, w0 : Int, x0 : Int, y0 : Int, z0 : Int,

			a1 : Int, b1 : Int, c1 : Int, d1 : Int, e1 : Int, f1 : Int, g1 : Int, h1 : Int, i1 : Int, j1 : Int,
			k1 : Int, l1 : Int, m1 : Int, n1 : Int, o1 : Int, p1 : Int, q1 : Int, r1 : Int, s1 : Int, t1 : Int,
			u1 : Int, v1 : Int, w1 : Int, x1 : Int, y1 : Int, z1 : Int,

			a2 : Int, b2 : Int, c2 : Int, d2 : Int, e2 : Int, f2 : Int, g2 : Int, h2 : Int, i2 : Int, j2 : Int,
			k2 : Int, l2 : Int, m2 : Int, n2 : Int, o2 : Int, p2 : Int, q2 : Int, r2 : Int, s2 : Int, t2 : Int,
			u2 : Int, v2 : Int, w2 : Int, x2 : Int, y2 : Int, z2 : Int,

			a3 : Int, b3 : Int, c3 : Int, d3 : Int, e3 : Int, f3 : Int, g3 : Int, h3 : Int, i3 : Int, j3 : Int,
			k3 : Int, l3 : Int, m3 : Int, n3 : Int, o3 : Int, p3 : Int, q3 : Int, r3 : Int, s3 : Int, t3 : Int,
			u3 : Int, v3 : Int, w3 : Int, x3 : Int, y3 : Int, z3 : Int,

			ans : Int
		in {
			-- Populate all 104 virtual registers
			a0 <- 1;
			b0 <- 2;
			c0 <- 3;
			d0 <- 4;
			e0 <- 5;
			f0 <- 6;
			g0 <- 7;
			h0 <- 8;
			i0 <- 9;
			j0 <- 10;
			k0 <- 11;
			l0 <- 12;
			m0 <- 13;
			n0 <- 14;
			o0 <- 15;
			p0 <- 16;
			q0 <- 17;
			r0 <- 18;
			s0 <- 19;
			t0 <- 20;
			u0 <- 21;
			v0 <- 22;
			w0 <- 23;
			x0 <- 24;
			y0 <- 25;
			z0 <- 26;

			a1 <- 1;
			b1 <- 2;
			c1 <- 3;
			d1 <- 4;
			e1 <- 5;
			f1 <- 6;
			g1 <- 7;
			h1 <- 8;
			i1 <- 9;
			j1 <- 10;
			k1 <- 11;
			l1 <- 12;
			m1 <- 13;
			n1 <- 14;
			o1 <- 15;
			p1 <- 16;
			q1 <- 17;
			r1 <- 18;
			s1 <- 19;
			t1 <- 20;
			u1 <- 21;
			v1 <- 22;
			w1 <- 23;
			x1 <- 24;
			y1 <- 25;
			z1 <- 26;

			a2 <- 1;
			b2 <- 2;
			c2 <- 3;
			d2 <- 4;
			e2 <- 5;
			f2 <- 6;
			g2 <- 7;
			h2 <- 8;
			i2 <- 9;
			j2 <- 10;
			k2 <- 11;
			l2 <- 12;
			m2 <- 13;
			n2 <- 14;
			o2 <- 15;
			p2 <- 16;
			q2 <- 17;
			r2 <- 18;
			s2 <- 19;
			t2 <- 20;
			u2 <- 21;
			v2 <- 22;
			w2 <- 23;
			x2 <- 24;
			y2 <- 25;
			z2 <- 26;

			a3 <- 1;
			b3 <- 2;
			c3 <- 3;
			d3 <- 4;
			e3 <- 5;
			f3 <- 6;
			g3 <- 7;
			h3 <- 8;
			i3 <- 9;
			j3 <- 10;
			k3 <- 11;
			l3 <- 12;
			m3 <- 13;
			n3 <- 14;
			o3 <- 15;
			p3 <- 16;
			q3 <- 17;
			r3 <- 18;
			s3 <- 19;
			t3 <- 20;
			u3 <- 21;
			v3 <- 22;
			w3 <- 23;
			x3 <- 24;
			y3 <- 25;
			z3 <- 26;

			-- Use all registers in a single operation
			ans <-
				a0 + b0 + c0 + d0 + e0 + f0 + g0 + h0 + i0 + j0 +
				k0 + l0 + m0 + n0 + o0 + p0 + q0 + r0 + s0 + t0 +
				u0 + v0 + w0 + x0 + y0 + z0 +
				a1 + b1 + c1 + d1 + e1 + f1 + g1 + h1 + i1 + j1 +
				k1 + l1 + m1 + n1 + o1 + p1 + q1 + r1 + s1 + t1 +
				u1 + v1 + w1 + x1 + y1 + z1 +
				a2 + b2 + c2 + d2 + e2 + f2 + g2 + h2 + i2 + j2 +
				k2 + l2 + m2 + n2 + o2 + p2 + q2 + r2 + s2 + t2 +
				u2 + v2 + w2 + x2 + y2 + z2 +
				a3 + b3 + c3 + d3 + e3 + f3 + g3 + h3 + i3 + j3 +
				k3 + l3 + m3 + n3 + o3 + p3 + q3 + r3 + s3 + t3 +
				u3 + v3 + w3 + x3 + y3 + z3;
			out_int(ans);
		}
	};
};