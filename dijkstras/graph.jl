# graph struct and methods

abstract type AbstractGraph end

struct Graph <: AbstractGraph
    vertices::Dict
    edges::AbstractArray{Nullable}
end

# TODO: Graph Constructor that validates the inputs
# TODO: Weighted / Unweighted, Directed / Undirected Graphs

function getedge(G::AbstractGraph, v, u)
    """Return the weight of the edge from v to u as a Nullable{T}"""
    # get the index of each vertex in G's dictionary
    # TODO: throw exception if not valid vertices
    vᵢ = G.vertices[v]
    uⱼ = G.vertices[u]

    # get the edge value, can be null
    return G.edges[vᵢ, uⱼ]
end

function getadjs(G::AbstractGraph, v)
    """Return an array of nodes adjacent to *v*."""
    # TODO: Make this handle undirected/directed edges in some way
    adjs = []
    for u in eachindex(G.vertices)
        if !isnull(getedge(G, v, u))
            push!(adjs, u)
        end
    end

    return Set(adjs)
end
