# graph struct and methods

abstract type AbstractGraph end

struct Graph <: AbstractGraph
    Vertices::Dict
    Edges::AbstractArray{Nullable}
end

function getedge(G::AbstractGraph, x, y)
    """Return the weight of the edge from x to y as a Nullable"""
    # get the index of each vertex in G's dictionary
    # TODO: throw exception if not valid vertices
    xᵢ = G.Vertices[x]
    yⱼ = G.Vertices[y]

    # get the edge value, can be null
    return G.Edges[xᵢ, yⱼ]
end
