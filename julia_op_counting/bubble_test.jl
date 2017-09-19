#= basic unit tests for bubble_sort
=#

using Base.Test
include("./bubble.jl")

# verify that bubble_sort throws an method error if input arg is not an array
@testset "Argument Tests" begin
    @test_throws MethodError bubble_sort(3.0) 
end

# verify that bubble_sort sorts various arrays
@testset "Sort Tests" begin
    @test bubble_sort([5, -1, 0]) == [-1, 0, 5]
    @test bubble_sort([-3, -3, -3, 0, -5, 10]) == [-5, -3, -3, -3, 0, 10]
end
