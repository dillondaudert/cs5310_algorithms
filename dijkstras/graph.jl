# graph struct and methods

abstract type AbstractGraph end

"Generic type for all graphs."
struct Graph <: AbstractGraph
    vertices::Dict
    edges::AbstractArray{Nullable}
    function Graph(vertices::Dict, edges::AbstractArray)
        """Inner constructor method for Graph.
        Validate edge matrix size."""
        # check that the size of edges is correct
        if (length(vertices), length(vertices)) != size(edges)
            error("invalid edge matrix: must be nxn where n is the number of vertices")
        end
        new(vertices, convert(AbstractArray{Nullable}, edges))
    end
end

"Return the weight of the edge from v to u as a Nullable{T}."
function getedge(G::AbstractGraph, v, u)
    # get the index of each vertex in G's dictionary
    vᵢ = G.vertices[v]
    uⱼ = G.vertices[u]

    # get the edge value, can be null
    return G.edges[vᵢ, uⱼ]
end

"Return an array of nodes adjacent to *v*."
function getadjs(G::AbstractGraph, v)
    # TODO: Make this handle undirected/directed edges in some way
    adjs = []
    for u in eachindex(G.vertices)
        if !isnull(getedge(G, v, u))
            push!(adjs, u)
        end
    end

    return Set(adjs)
end
