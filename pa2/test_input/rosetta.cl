(* A.J. Varshneya
 * ajv4dg@virginia.edu
 * CS4501 - Language Design & Implementation
 * 1/25/16
 * rosetta.cl
 * 
 * Helpful things:
 * - Wikipedia topsort algorithms: https://en.wikipedia.org/wiki/Topological_sorting
 * - DFS-based top sort algorithm I used (like Tarjans?): http://www.inf.ed.ac.uk/teaching/courses/cs2/LectureNotes/CS2Bh/ADS/ads10.pdf
 * - Cool reference manual: https://theory.stanford.edu/~aiken/software/cool/cool-manual.pdf
 * - List code provided by course, CS4501 LDI, with some modifications
 *)

Class Main inherits IO {
	graph : Dict <- new NilDict;
	sorted_list : List <- new NilList;
	cycle : Bool <- false;

	main() : Object { 
		{
			-- Construct graph from input
			let done : Bool <- false 
			in {
				while not done loop {
					let dst : String <- in_string()
					in {
						if dst = "" then
							done <- true
						else {
							
							let src : String <- in_string()
							in {
								-- Add the pair as keys in the graph if not already added
								if not graph.has_key(src) then {
									let adj_list : List <- new NilList
									in {
										graph <- graph.put(src, adj_list, 0);
									};
								}
								else
									out_string("")
								fi;

								if not graph.has_key(dst) then {
									let adj_list : List <- new NilList
									in {
										graph <- graph.put(dst, adj_list, 0);
									};
								}
								else
									out_string("")
								fi;

								-- Add edge to graph
								let adj_list : List <- graph.get(src).get_value()
								in {
									graph <- graph.remove(src); -- Remove old src/adjlist pair
									adj_list <- adj_list.insert(dst); -- Add new dst to adjlist
									graph <- graph.put(src, adj_list, 0); -- Put new adjlist back in graph
								};
							};
						}
						fi;
					};
				} pool;
			};
			top_sort(graph);
			if not cycle then
				sorted_list.print()
			else
				out_string("")
			fi;
		}
	};

	-- This function is used so that we can recursively iterate over the keys
	top_sort(node : Dict) : Object {
		if not node.get_key() = "" then {
			if graph.get(node.get_key()).get_mark() = 0 then {
				visit(node);
			}
			else
				out_string("")
			fi;
			top_sort(node.get_tail());
		}
		else
			out_string("")
		fi
	};

	visit(node: Dict) : Object { 
		{(*
			out_string("Visiting... ");
			out_string(node.get_key());
			out_string("\n");*)
			let temp : Dict <- node
			in {
				graph <- graph.remove(node.get_key());
				graph <- graph.put(temp.get_key(), temp.get_value(), 1);
			};

			visit_helper(node.get_value());

			let temp : Dict <- node
			in {
				graph <- graph.remove(node.get_key());
				graph <- graph.put(temp.get_key(), temp.get_value(), 2);
			};

			sorted_list <- sorted_list.prepend(node.get_key());

		}
	};

	-- Iterates over adj list
	visit_helper(adj : List) : Object {
		if not adj.get_head() = "" then {
			let node : Dict <- graph.get(adj.get_head())
			in {
				if node.get_mark() = 0 then {
					visit(node);
				}
				else {
					-- There's a cycle!!!
					if node.get_mark() = 1 then {
						out_string("cycle\n");
						cycle <- true;
						--abort();
					}
					else
						out_string("")
					fi;
				}
				fi;
			};
			visit_helper(adj.get_tail());
		}
		else
			out_string("")
		fi
	};
};

(* List abstract *)
Class List inherits IO {

	(* Returns new 'ConsList' (a list) with 'head' as the first element
	 * and 'self' as the rest of the list *)
	cons(head : String) : ConsList {
		let cell : ConsList <- new ConsList in
			cell.init(head, self)
	};

	get_head() : String { "" };
	get_tail() : List { self };
	insert(s : String) : List { self };
	prepend(s : String) : List { self };
	print() : Object { abort() };
};

-- Non-empty list
Class ConsList inherits List {
	head : String; -- List head value
	tail : List; -- Sublist following the head

	init(h : String, t : List) : ConsList {
		{
			head <- h;
			tail <- t;
			self;
		}
	};

	get_head() : String { head };

	get_tail() : List { tail };

	-- Insert new item in sorted order (insertion sort)
	insert(s : String) : List {
		{
			if head < s then {
				(new ConsList).init(s, self);
			}
			else {
				(new ConsList).init(head, tail.insert(s));
			}
			fi;
		}
	};

	prepend(s : String) : List {
		(new ConsList.init(s, self))
	};

	print() : Object {
		{
			out_string(head);
			out_string("\n");
			tail.print();
		}
	};
};

-- Empty list
Class NilList inherits List {
	get_tail() : List { self };
	get_head() : String { "" };
	prepend(s : String) : List { (new ConsList).init(s, self) };
	insert(s : String) : List { (new ConsList).init(s, self) };
	remove(s : String) : List { self };
	print() : Object { true }; -- do nothing
};

(* Dict abstract *)
Class Dict inherits IO {

	construct(k : String, v : List, m : Int) : ConsDict {
		let cell : ConsDict <- new ConsDict in
			cell.init(k, v, m, self)
	};

	has_key(k : String) : Bool { false };
	get_key() : String { "" };
	set_key(k : String) : Dict { self };
	get_value() : List { new NilList };
	set_value(v : List) : Dict { self };
	get_mark() : Int { 0 };
	set_mark(m : Int) : Dict { self };
	get_tail() : Dict { self };
	set_tail(t : Dict) : Dict { self };
	get(k : String) : Dict { self };
	put(k : String, v : List, m : Int) : Dict { self };
	remove(k : String) : Dict { self };
	print() : Object { abort() };
};

-- Non-empty Dict
Class ConsDict inherits Dict {
	key : String; -- Key
	value : List; -- Value
	mark : Int; -- 0 - White, 1 - Gray, 2 - Black
	tail : Dict; -- subdictionary after this cell

	init(k : String, v : List, m : Int, t : Dict) : ConsDict {
		{
			key <- k;
			value <- v;
			mark <- m;
			tail <- t;
			self;
		}
	};

	has_key(k : String) : Bool {
		if key = k then
			true
		else
			tail.has_key(k)
		fi
	};

	get_key() : String { key };

	set_key(k : String) : Dict {
		{
			key <- k;
			self;
		}
	};

	get_value() : List { value };

	set_value(v : List) : Dict {
		{
			value <- v;
			self;
		}
	};

	get_mark() : Int { mark };

	set_mark(m : Int) : Dict {
		{
			mark <- m;
			self;
		}
	};

	get_tail() : Dict { tail };

	set_tail(t : Dict) : Dict {
		{
			tail <- t;
			self;
		}
	};

	(* Removes key/associated value by replacing tail in 
	 * dict with tail of dict with given key *)
	remove(k : String) : Dict {
		if k = key then
			tail
		else {
			tail <- tail.remove(k);
			self;
		}
		fi
	};

	get(k : String) : Dict {
		if k = key then 
			self
		else 
			tail.get(k)
		fi
	};

	-- Insert new item sorted by keys
	put(k : String, v : List, m : Int) : Dict { 
		{
			if key < k then
				(new ConsDict).init(k, v, m, self)
			else
				(new ConsDict).init(key, value, mark, tail.put(k,v,m))
			fi;
		}
	};

	print() : Object {
		{
			out_string(key);
			tail.print();
		}
	};
};

-- Empty Dict
Class NilDict inherits Dict {
	has_key(k : String) : Bool { false }; 
	get_key() : String { "" };
	set_key(k : String) : Dict { self };
	get_value() : List { new NilList };
	set_value(v : List) : Dict { self };
	get_mark() : Int { 0 };
	set_mark(m : Int) : Dict { self };
	get_tail() : Dict { self };
	set_tail(t : Dict) : Dict { self };
	remove(k : String) : Dict { self };
	get(k : String) : Dict { self }; -- key not in dict

	put(k : String, v: List, m : Int) : Dict { 
		{
			(new ConsDict).init(k, v, m, self);
		}
	};

	print() : Object { true }; -- do nothing
};