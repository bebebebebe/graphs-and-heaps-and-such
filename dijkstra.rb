require_relative './heap'

# Assume graph is given by an adjacency list like this:
# [
#   [[v2, n1], [v3, n2], [v4, n3]],
#   [[v5, n4], [v6, n5], [v7, n6]],
#   [[v1, n7], ...]
#   ...
# ]
# The rows correspond to the vertices of the graph, with the first row for vertex 0.
# The elements of the array on row i represent the edges from vertex i.
# Each vi is a number (0,1,2,...) representing the vertex for that row number.
# Each n is a positive integer representing the weight of the edge.
#
# Goal: using vi as the start vertex, find shortest distances from vi to each vertex.
# Return hash with keys the vertices reachable from vi and values the shortest path length from vi.

# Return array of path lengths [l0, l1, l2, ...] with li length of shortest path from 
# v1 to li. If there is no path, set li = nil.

class Dijkstra

  def initialize(graph, node)
    @graph = graph

    @heap = [node]
    @pos = {node => 0}
    @val = {node => 0}

    @h = Heap.new(@heap, @pos, @val)
  end

  def run
    step while @heap.length != 0
    @val
  end

  def step
    v = @h.extract_min
    @graph[v].each {|w|
      score = score(v, w)
      if not @val.has_key? w[0]
        @val[w[0]] = score
        @h.ins(w[0], score)
      elsif score < @val[w[0]]
        @h.val_upd(w[0], score)
      end
    }
  end

  # v: integer, element with key in @val
  # w: element of @graph[v]
  def score(v, w)
    @val[v] + w[1]
  end
end

graph = [
  [[1,1],[2,4]],
  [[2,2],[3,6]],
  [[3,3]],
  []
]

d = Dijkstra.new(graph, 0)
puts d.run.inspect
# should be: {0:0, 1:1, 2:3, 3:6}
