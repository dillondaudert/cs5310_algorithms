# Date: 12/1/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 5

using Base.Test
include("../basic.jl")

A = [-1/6 -1/6 1/3;
     8/3 2/3 -1/3;
     1/2 -1/2 0;]
c = [-1/6 -1/6 -2/3]
b = [8. 4. 18.]

trueA′ = [-1/6 -1/6 1/3 0 0 0;
          8/3 2/3 -1/3 0 0 0;
          1/2 -1/2 0 0 0 0;
          0 0 0 0 0 0;
          0 0 0 0 0 0;
          0 0 0 0 0 0]
truec′ = [-1/6 -1/6 -2/3 0 0 0]
trueb′ = [8. 4. 18. 0. 0. 0.]

trueLₐ = [-1. -1/6 -1/6 1/3;
     -1. 8/3 2/3 -1/3;
     -1. 1/2 -1/2 0;]
truecₐ = [-1. 0. 0. 0.]

@testset "All Tests" begin
    @testset "Expand Tests" begin
        (A′, b′, c′) = expandlp(A, b, c)
        @test A′ == trueA′
        @test b′ == trueb′
        @test c′ == truec′
    end

    @testset "Auxiliary Tests" begin
        Lₐ, bₐ, cₐ = auxlp(A, b, c)
        @test Lₐ == trueLₐ
        @test bₐ == b
        @test cₐ == truecₐ
    end

end
