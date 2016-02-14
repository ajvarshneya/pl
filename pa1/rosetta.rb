require 'set'

graph = Hash.new()
indegree = Hash.new()
start = Set.new()
cycle = false

while true
	# Get src/dst from stdin
	dst = gets
	if dst == nil
		break
	end
	src = gets

	dst.strip!
	src.strip!

	# Add nodes to graph/indegrees/start set
	if !graph.has_key?(dst)
		graph[dst] = []
		indegree[dst] = 0
		start << dst
	end #endif


	if !graph.has_key?(src)
		graph[src] = []
		indegree[src] = 0
		start << src
	end #endif

	# Add edge to graph, increment indegree of dst
	graph[src] << dst
	indegree[dst] += 1
end

# graph.each{|key,value| puts "#{key}: #{value}"}

# Get nodes with indegree zero
start.each do |node|
	if (indegree[node] != 0)
		start.delete(node)
	end
end

if start.empty?()
	cycle = true
end

sorted = []

while !start.empty?()
	# Get min
	src = start.to_a().min()

	# Remove min, add to sorted
	start.delete(src)
	sorted << src

	graph[src].each do |dst|
		indegree[dst] -= 1
		if indegree[dst] == 0
			start << dst
		end
	end
end

indegree.each_value do |value|
	if (value != 0)
		cycle = true
	end
end

if cycle
	puts "cycle"
else
	sorted.each {|n| puts "#{n}\n"}
end