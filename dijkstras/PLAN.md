# Dijkstra's Algorithm in Julia
An implementation of an All-Pairs Shortest Path algorithm, using Dijkstra's. 

## Structures
Dijkstra's algorithm operates on a weighted, undirected graph, where the weights are nonnegative.

```julia
struct WeightedGraph
    Vertices::Dict
    Edges::AbstractArray
end

function getindex(::WeightedGraph, ::String, ::String)
"""Retrieve the weight of the edge between two nodes."""
end
```

## Functions

```julia
function DikjstraShortest(G::Graph, V::String, W::String)
"""Return the shortest path between the two vertices V and W in graph G"""
end


function AllShortestPaths(G::Graph)
"""Return the shortest path between all pairs of vertices in G.
Result is 2D array where each i,j entry is the shortest path 
between vertex i and vertex j."""
end
```
