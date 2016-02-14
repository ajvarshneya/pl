var readline = require('readline');

var rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout,
	terminal: false
});

var graph = {};
var indegree = {};
var start = [];
var lines = [];
var cycle = false;

// Read input, called on '\n' characters
rl.on('line', function(line) {
	lines.push(line)
});

// Main body
rl.on('close', function() {

	var dst = "";
	var src = "";

	// Construct graph from buffered input
	for (i = 0; i < lines.length; i += 2) {
		dst = lines[i];
		src = lines[i+1];

		// Add nodes to graph if newly encountered
		if (!(src in graph)) {
			graph[src] = [];
			indegree[src] = 0;
		}

		if (!(dst in graph)) {
			graph[dst] = [];
			indegree[dst] = 0;
		}

		// Add edge to graph
		graph[src].push(dst);

		// Increment indegree of dst
		indegree[dst] = indegree[dst] + 1;
	}

	// Construct start set
	for (key in indegree) {
		if (indegree[key] == 0) {
			start.push(key);
		}
	}

	// No nodes w/ indegree zero -> cycle
	if (start.length == 0) {
		cycle = true;
	}

	// Top sort
	var sorted = []

	while (start.length > 0) {
		// Get minimum node from start set
		src = start[0];
		start.forEach(function(node) {
			if (src.localeCompare(node) > 0) {
				src = node;
			}
		});

		// Remove node from start set, append to sorted list
		start.splice(start.indexOf(src), 1);
		sorted.push(src);

		// Decrement indegrees of adjacent nodes
		adj = graph[src];

		if (adj.length > 0) {
			adj.forEach(function(dst) {
				indegree[dst] = indegree[dst] - 1;

				// Check for new start nodes
				if (indegree[dst] == 0) {
					start.push(dst);
				}
			});
		}

	}

	// Non-empty graph -> cycle
	for (key in indegree) {
		if (indegree[key] != 0) {
			cycle = true;
		}
	}

	// Output
	if (cycle) {
		process.stdout.write("cycle\n");
	} else {
		sorted.forEach(function(node) {
			process.stdout.write(node + "\n");
		});
	}
});
