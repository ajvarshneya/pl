-- Spencer Gennari (sdg6vt)
-- PA1
-- 2/02/16
-- NOTE:
-- This code uses a list class with many shared ideas from the Cool example
-- programs sort-list.cl and list.cl (no code was directly copied, however)

class Main inherits IO {

	main() : Object {
		{
			let
				adj_list : ListElem
			in {
				adj_list <- read_task_list();
				top_sort(adj_list);
			};
		}
	};

	read_task_list() : ListElem {
		let
			is_done : Bool <- false,
			adj_list : ListElem <- new ListEnd
		in {
			while not is_done loop {
				let
					dep : String,
					task : String
				in {
					dep <- in_string();
					if dep = "" then
						is_done <- true		-- EOF input, so exit loop
					else {
						task <- in_string();

						-- Add task if not added
						if not adj_list.contains(task) then
							adj_list <- adj_list.insert(task)
						else
							out_string("")
						fi;

						-- Add dep to task
						adj_list.add_dep(task, dep);

						-- Add dep if not added
						if not adj_list.contains(dep) then
							adj_list <- adj_list.insert(dep)
						else
							out_string("")
						fi;

						-- Increment indegree of task
						adj_list.inc_indegree(dep);
					}
					fi;
				};
			}
			pool;
			adj_list;
		}
	};

	top_sort(adj_list : ListElem) : Object {
		{
			let
				sorted_tasks : ListElem <- new ListEnd,
				no_req_tasks : ListElem <- new ListEnd
			in {
				-- Get a list of tasks with indegree 0
				let
					cur_node : ListElem <- adj_list
				in {
					while cur_node.has_next() loop {
						if cur_node.get_indegree() = 0 then
							no_req_tasks <- no_req_tasks.insert(cur_node.get_val())
						else
							out_string("")
						fi;
						cur_node <- cur_node.get_next();
					}
					pool;
				};

				-- Iterate over all tasks without requirements
				let
					cur_task : String
				in {
					while not no_req_tasks.type_name() = "ListEnd" loop {
						-- Remove min task for no_req_tasks
						cur_task <- get_list_min_val(no_req_tasks);
						no_req_tasks <- no_req_tasks.remove(cur_task);
						sorted_tasks <- sorted_tasks.insert(cur_task);

						-- Decrement indegree of dependent nodes
						let
							cur_indegree : Int,
							cur_dep_node : ListElem <- adj_list.get_dep_list(cur_task)
						in {
							while cur_dep_node.has_next() loop {
								cur_indegree <- adj_list.dec_indegree(cur_dep_node.get_val());
								if cur_indegree = 0 then
									no_req_tasks <- no_req_tasks.insert(cur_dep_node.get_val())
								else
									out_string("")
								fi;

								-- Advance iterator
								cur_dep_node <- cur_dep_node.get_next();
							}
							pool;
						};
					}
					pool;
				};

				-- Print output
				let
					has_cycle : Bool <- false
				in {
					while adj_list.has_next() loop {
						if not adj_list.get_indegree() = 0 then
							has_cycle <- true
						else
							out_string("")
						fi;
						adj_list <- adj_list.get_next();
					}
					pool;

					if has_cycle then
						out_string("cycle\n")
					else
						sorted_tasks.print_list()
					fi;
				};
			};
		}
	};

	get_list_min_val(list : ListElem) : String {
		{
			let
				min : String <- list.get_val(),	-- Init min as first item in list
				cur_node : ListElem <- list
			in {
				while cur_node.has_next() loop {	-- Update min if current val is smaller
					if cur_node.get_val() < min then
						min <- cur_node.get_val()
					else
						out_string("")
					fi;
					cur_node <- cur_node.get_next();
				}
				pool;
				min;
			};
		}
	};

};

(* Base class for a linked list. Acts similar to an abstract class *)
class ListElem inherits IO {

	get_val() : String { { abort();	new String;	} };

	get_indegree() : Int { { abort(); new Int; } };

	get_next() : ListElem {	self };

	has_next() : Bool { false };

	get_dep_list(task : String) : ListElem { { abort(); new ListEnd; } };

	contains(task : String) : Bool { { abort(); false; } };

	inc_indegree(task : String) : Int { { abort(); new Int; } };

	dec_indegree(task : String) : Int { { abort(); new Int; } };

	add_dep(task : String, dep : String) : Object { abort() };

	insert(task : String) : ListElem { self };

	remove(task : String) : ListElem { self };

	print_list() : Object { abort() };
};

(* Data node in the linked list *)
class ListNode inherits ListElem {

	-- Task data
	val : String;
	indegree : Int;
	dep_list : ListElem;

	-- Next node in list
	next : ListElem;

	init(task : String, tail : ListElem) : ListElem {
		{
			val <- task;
			indegree <- 0;
			dep_list <- new ListEnd;
			next <- tail;
			self;	-- Return this node
		}
	};

	get_val() : String { val };

	get_indegree() : Int { indegree };

	get_dep_list(task : String) : ListElem {
		if task = val then
			dep_list
		else
			next.get_dep_list(task)
		fi
	};

	get_next() : ListElem { next };

	has_next() : Bool { true };

	contains(task : String) : Bool {
		if task = val then
			true
		else
			next.contains(task)
		fi
	};

	inc_indegree(task : String) : Int {
		if val = task then {
			indegree <- indegree + 1;
			indegree;
		}
		else
			next.inc_indegree(task)
		fi
	};

	dec_indegree(task : String) : Int {
		if val = task then {
			indegree <- indegree - 1;
			indegree;
		}
		else
			next.dec_indegree(task)
		fi
	};

	add_dep(task: String, dep : String) : Object {
		if task = val then
			dep_list <- dep_list.insert(dep)
		else
			next.add_dep(task, dep)
		fi
	};

	insert(task : String) : ListElem { (new ListNode).init(task, self) };

	remove(task : String) : ListElem  {
		if task = val then {
			next;	-- Return next node
		}
		else {
			next <- next.remove(task);
			self;
		}
		fi
	};

	print_list() : Object {
		{
			next.print_list();
			out_string(val);
			out_string("\n");
		}
	};
};

(* Marker for end of list *)
class ListEnd inherits ListElem {

	insert(task : String) : ListElem { (new ListNode).init(task, self) };

	remove(task : String) : ListElem { self };

	get_next() : ListElem { self };

	has_next() : Bool { false };

	contains(task :String) : Bool { false };

	print_list() : Object { false };
};