(*Sources
 - https://ocaml.org/learn/tutorials/set.html
 - Used to understand folding to get min: http://rosettacode.org/wiki/Greatest_element_of_a_list#OCaml
 *)

(* Wish I hadn't used so much imperative style programming in this one, but functional is hard :( *)

module StringSet = Set.Make(String);;

(* Too many references, I know, I am ashamed *)
let nodes = ref [];; (* List of strings representing nodes in graph *)
let starts = ref [];; (* Nodes with indegree zero *)
let sorted = ref [];;
let graph = Hashtbl.create 1024;; (* Adjacency list *)
let indegrees = Hashtbl.create 1024;; (* node (string) maps to color (int) *)
let finished = ref false;;

(* Prints the passed list *)
let rec print_list lst = match lst with
	  [] -> ()
	| hd :: tl -> 
	(
		print_string hd;
		print_string "\n";
		print_list tl
	)
;;

(* Returns indegree of node *)
let indegree_of node =
	(Hashtbl.find indegrees node)
;;

(* Decrements indegree of specified node *)
let dec_indegree node = 
	(Hashtbl.replace indegrees node ((Hashtbl.find indegrees node) - 1));
	()
;;

(* Increments indegree of specified node *)
let inc_indegree node = 
	Hashtbl.replace indegrees node ((Hashtbl.find indegrees node) + 1);
	()
;;

(* Returns list with specified string removed *)
let rec remove str lst = match lst with
	  [] -> []
	| hd :: tl when hd = str -> tl
	| hd :: tl -> hd :: remove str tl
;;

(* Returns minimum element in list *)
let list_min lst = match lst with
	  [] ->  invalid_arg "List is empty."
	| hd :: tl -> List.fold_left min hd tl
;;

(* Returns list of nodes with indegree zero *)
let rec get_starts acc lst = match lst with
	  [] -> acc
	| hd :: tl ->
	(
		if ((Hashtbl.find indegrees hd) = 0) then
			hd :: (get_starts acc tl)
		else 
			get_starts acc tl
	)
;;

(* Iterate over adjacent nodes, decrementing their indegree and adding to starts if indegree 0 *)
let rec check_starts adj = match adj with
	  [] -> ()
	| hd :: tl ->
	(
		dec_indegree hd;
		if (indegree_of hd) = 0 then
		(
			starts := (hd :: !starts);
			check_starts tl;
		)
		else
			check_starts tl;
	)
;;

(* Checks if there are nodes with non-zero indegree *)
let rec graph_empty lst = match lst with
	  [] -> true
	| hd :: tl -> 
		((Hashtbl.find indegrees hd) = 0) && 
		graph_empty tl

let main () =
	try
		while true do 
			let dst = (read_line ()) and src = (read_line ()) 
			in
				(* If this is the first time src has been encountered *)
 				if not (Hashtbl.mem graph src) then 
 				(
					Hashtbl.add graph src ""; (* Add it to the graph *)
					Hashtbl.add indegrees src 0; (* Keep track of its indegree *)
					nodes := src :: !nodes; (* Add it to our list of nodes *)
				);

				(* If this is the first time src has been encountered *)
				if not (Hashtbl.mem graph dst) then
				(
					Hashtbl.add graph dst ""; (* Add it to the graph *)
					Hashtbl.add indegrees dst 0; (* Keep track of its indegree *)
					nodes := dst :: !nodes; (* Add it to our list of nodes *)
				);

				(* Add edge to graph *)
				if (Hashtbl.find graph src) = "" then
					Hashtbl.replace graph src dst (* Replace the adj list if its empty *)
				else
					Hashtbl.add graph src dst;

				(* Increment dst indegree *)
				inc_indegree dst
		done
	with _ -> 
	begin
		(* Construct set of nodes with indegree zero *)

		starts := (get_starts [] !nodes);

		if !starts = [] then 
			print_string "cycle\n"
		else (

			(* Top sort with Kahn's algorithm *)
			while not !finished do
				let src = list_min !starts
				in
					starts := (remove src !starts);
					sorted := !sorted @ [src]; 

					let adj = (Hashtbl.find_all graph src)
					in 
						if adj <> [""] then
							check_starts adj
						else ();

					if !starts = [] then
						finished := true
					else ();
			done;

			if not (graph_empty !nodes) then
				print_string "cycle\n"
			else print_list !sorted;
		)
	end
;;

main();;