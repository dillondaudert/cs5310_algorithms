# Plot the running time of nxn matrix multiplication for the matmul_rec function

using Plots
include("./bench.jl")

"Plot the running time of matmul_rec"
function plot_times(times::AbstractArray)
    # plot the running times
    x = 1:size(times,1)
    display(plot(x,
                 times,
                 xaxis = ("Dimension", (x, [2^n for n in 0:size(times,1)-1])),
                 yaxis = ("Mean Execution Time (s)")))
    # save the figure
    savefig("matmul_times.png")
end
