# main execution loop

include("./bench.jl")
include("./visual.jl")

function main()
    times = time_matmul(9, 100)
    plot_times(times)
end

main()
