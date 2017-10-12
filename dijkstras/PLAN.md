# Dijkstra's Algorithm in Julia
An implementation of an All-Pairs Shortest Path algorithm, using Dijkstra's. 

## Structures
Dijkstra's algorithm operates on a weighted, undirected graph, where the weights are nonnegative.

```julia
struct WeightedGraph
    Vertices::AbstractArray
    Edges::AbstractArray
end
```

## Functions

```julia
function DikjstraShortest()

```
