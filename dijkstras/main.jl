# Class: CS 5310
# Date: 10/24/2017
# Assignment: 4
# Author: Dillon Daudert

include("./parse.jl")
include("./graph.jl")
include("./paths.jl")

function main(args)
    # get the file to open
    infile = length(args) == 0 ? "./test/ex_graph.txt" : args[1]    

    f = open(infile, "r")
    V,E = parsegraph(f)
    close(f)

    G = Graph(V, E)

    paths = allshortestpaths(G)

    # append the vertex names to the top row and left column
    nice_paths = Array{Any}(size(paths,1)+1, size(paths, 1)+1)
    nice_paths[1,1] = ""
    for (v, i) in V
        nice_paths[1, i+1] = v
        nice_paths[i+1, 1] = v
    end

    nice_paths[2:size(nice_paths,1), 2:size(nice_paths,1)] = paths

    @printf("All shortest paths:\n")
    display(nice_paths)
    print("\n")

end

main(ARGS)
