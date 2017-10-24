# shortest path algorithms

using DataStructures

"""
Find the shortest path in a weighted, undirected graph from *start* to 
all other nodes in *G*.
Return an array of distances.
"""
function dijkstra(G::AbstractGraph, start)

    # TODO: Verify in some way (here or via dispatch) that graph is nonnegative,
    #       weighted, undirected
    
    # initialize distances to infinity
    D = fill(Inf, length(G.vertices))
    D[G.vertices[start]] = 0

    # Q is a priority queue
    Q = PriorityQueue{String, Float64}()
    # add each node to the queue, distances are ∞
    for (node, value) in G.vertices
        enqueue!(Q, node, D[value])
    end

    visited = Set() 

    while !isempty(Q)
        # pull a new vertex into the cloud
        node = dequeue!(Q)
        push!(visited, node)
        # for each vertex adjacent to node s.t. it is in Q
        for adj in getadjs(G, node)
            if (adj => D[G.vertices[adj]]) in Q
                # relaxation procedure
                newdist = D[G.vertices[node]] + getedge(G, node, adj).value
                if newdist < D[G.vertices[adj]]
                    #@printf("Updating distance (%s, %s) = %2.1f\n", node, adj, newdist)
                    # update distance to adj and update Q
                    D[G.vertices[adj]] = newdist
                    Q[adj] = newdist
                end
            end
        end
    end
    return D
end

"""
Find shortest paths between all pairs of nodes in G.
Return a 2D array of distances.
"""
function allshortestpaths(G::AbstractGraph)

    # matrix of shortest paths
    D = Array{Real}(size(G.edges)...)
    # iterate through each node
    for (v, i) in G.vertices
        Dᵥ = dijkstra(G, v)
        D[:,i] = Dᵥ
    end

    return D
end
