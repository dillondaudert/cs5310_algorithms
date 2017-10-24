# example driver script

include("./io.jl")
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

    display(paths)

end

main(ARGS)
