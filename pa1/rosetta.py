'''
A.J. Varshneya
ajv4dg@virginia.edu
CS4501 - Language Design & Implementation
1/25/16
rosetta.py

 Notes
 - Python is nice.

Links that were helpful:
- Kahn's algorithm: https://en.wikipedia.org/wiki/Topological_sorting

'''
from sys import stdin
import os 

def main():
	graph = {}
	indegrees = {}

	# populate adjacency list from stdin
	while (True):
		# read from stdin
		dst = str(stdin.readline().strip())

		#dst = str(my_file.readline().strip())

		if (dst == ''):
			break
		src = str(stdin.readline().strip())
		
		#src = str(my_file.readline().strip())

		# add nodes to graph
		if src not in graph:
			graph[src] = list()
		if dst not in graph:
			graph[dst] = list()
	
		# add edge to graph
		graph[src].append(dst)

		# keep track of indegree
		if src not in indegrees:
			indegrees[src] = 0
		if dst not in indegrees:
			indegrees[dst] = 0

		indegrees[dst] += 1

	# construct set of nodes with no incoming edges
	start_nodes = set()
	for node in indegrees:
		if indegrees[node] == 0:
			start_nodes.add(node)

	# use Kahn's algorithm to top sort
	sorted_nodes = []
	while (start_nodes):
		src = min(start_nodes)
		start_nodes.remove(src)

		sorted_nodes.append(src)

		# remove edge from selected node to each of its adjacent nodes
		for dst in graph[src]:
			indegrees[dst] -= 1

			# add dst nodes to start_node candidates set when there are no more incoming edges
			if indegrees[dst] == 0:
				start_nodes.add(dst)

		del graph[src][:]

	for src in graph:
		if graph[src]:
			print 'cycle'
			exit(1)

	# print sorted list of nodes
	for node in sorted_nodes:
		print node

if __name__ == '__main__':
	main()