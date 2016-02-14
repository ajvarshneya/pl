import Control.Monad
import Data.List

main = do

	input_buffer <- getContents

	let split_buffer = lines input_buffer

	let nodes = sort (nub split_buffer) 

	let dst = (map head . takeWhile (not . null) . iterate (drop 2)) split_buffer
	let src = (map head . takeWhile (not . null) . iterate (drop 2)) (tail split_buffer)
	let graph = sort (src `zip` dst)

	-- If there are no remaining nodes, return empty
	let get_start_nodes graph nodes
		| null nodes = []
		| otherwise = do
			-- Get head node
			let node = head nodes
			-- Check if that node has nonzero indegree
			let zero_indegree = notElem node (map snd graph)
			-- If it's indegree is zero, add it to the list, recurse
			if zero_indegree then
				node : (get_start_nodes graph (tail nodes))
			else 
				get_start_nodes graph (tail nodes)

	-- If there are no more edges, return empty
	let get_subgraph node subgraph
		| null subgraph = []
		| otherwise = do
			-- Get src of first edge in subgraph
			let src = fst (head subgraph)

			-- Add edge to subgraph if src isn't the node, recurse
			if (node == src) then
				get_subgraph node (tail subgraph)
			else
				(head subgraph) : (get_subgraph node (tail subgraph))

	let cycle = null (get_start_nodes graph nodes)

	let toposort graph nodes
		| null graph = nodes
		| otherwise = do
			-- Get a set of nodes with indegree zero
			let start_nodes = nub (get_start_nodes graph nodes)

			-- Select the first node in that set
			let node = head (sort start_nodes)

			-- Remove all edges with that node as the source
			let subgraph = get_subgraph node graph

			-- Remove the node from the active node set
			let new_nodes = (delete node nodes)

			(node : (toposort subgraph new_nodes))

	if cycle then
		putStrLn "cycle"
	else
		mapM putStrLn (toposort graph nodes)

