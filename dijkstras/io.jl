# function that opens a graph input file and returns a tuple (Dict, array)

"""
Parse a graph text file.
Return a tuple: (Dictionary of vertices, 2D array of edges.
"""
function parsegraph(file)
    # TODO: Check file format ...
    # read all text and split on new lines
    lines = split(String(read(file)), r"(\r)?\n")

    # first line is the nodes
    nodes = split(lines[1], ",")

    # build the dictionary of vertices
    vertices = Dict()
    for i = 1:length(nodes)
        vertices[nodes[i]] = i
    end

    # instantiate edges matrix
    edges = Array{Nullable{Float64}}(length(nodes), length(nodes))

    # for each line after the first
    for i = 2:length(lines)
        _edges = split(lines[i], ',')
        # convert to Nullable{Float}
        edges[i-1,:] = map(x->tryparse(Float64, x), _edges)
    end
    
    # create the graph and return
    return vertices, edges
end
