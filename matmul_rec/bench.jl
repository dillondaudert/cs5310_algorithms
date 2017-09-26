# Date: 09/22/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 3

include("./matmul.jl")

"""
Calculate mean running times of matmul_rec.
    maxsize - the maximum size of the matrix (as 2^(maxsize))
    nsamples - the number of samples to generate for each size
"""
function time_matmul(maxsize, nsamples)
    # generate float arrays of size 1x1
    samples = rand(Float64, 1, 1, 2, 1)

    # compile and run function once 
    matmul_rec(samples[:,:,1,1], samples[:,:,2,1])

    times = []

    for i in 0:maxsize
        # generate nsamples of 2^i x 2^i matrices
        samples = rand(Float64, 2^i, 2^i, 2, nsamples)
        @printf("Timing %dx%d matrices\n", 2^i, 2^i)
        # store the times in an array
        res = @timed push!(times, mean([@elapsed matmul_rec(samples[:,:,1,i], samples[:,:,2,i]) for i in 1:nsamples]))
        # print total time taken
        println(repr(res[2]), " seconds")
    end

    return times
end
