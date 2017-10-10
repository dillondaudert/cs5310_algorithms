include("./quicksort.jl")

"""
Calculate mean running times of quicksort vs Julia's sort function.
    maxsize - the maximum size of the array
    nsamples - the number of samples to generate for each size
"""
function time_quicksort(maxsize, nsamples)
    # generate a single float array of size 1
    samples = rand(Float64, 1, 1)

    # compile and run function once 
    MyQuicksort.Quicksort!(samples[:,1])

    my_times = []
    their_times = []

    for i in 1:maxsize
        # generate nsamples of ix1 arrays
        samples = rand(Float64, i, nsamples)
        @printf("Timing size-%d arrays\n", i)
        # store the times in an array
        res = @timed push!(my_times, mean([@elapsed MyQuicksort.Quicksort!(samples[:,i]) for i in 1:nsamples]))
        # print total time taken
        println(repr(res[2]), " seconds")
    end

    return my_times
end
