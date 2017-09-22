# Date: 09/22/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 3

include("./matmul.jl")

function time_matmul()
    # generate float arrays of size 1x1
    samples = rand(Float64, 1, 1, 2, 1)

    # compile and run function once 
    matmul_rec(samples[:,:,1,1], samples[:,:,2,1])

    times = []

    for i in 0:7
        samples = rand(Float64, 2^i, 2^i, 2, 100)
        @printf("Timing %dx%d matrices\n", 2^i, 2^i)
        push!(times, mean([@elapsed matmul_rec(samples[:,:,1,i], samples[:,:,2,i]) for i in 1:size(samples,4)]))
    end

    return times
end
