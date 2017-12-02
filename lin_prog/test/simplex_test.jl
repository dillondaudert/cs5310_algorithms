# Date: 12/1/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 5

using Base.Test
include("../simplex.jl")

N = IntSet([3, 5, 6])
B = IntSet([1, 2, 4])
en = 6
lv = 1
A = [0 0 -1/6 0 -1/6 1/3;
     0 0 8/3 0 2/3 -1/3;
     0 0 0 0 0 0;
     0 0 1/2 0 -1/2 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;]
c = [0 0 -1/6 0 -1/6 -2/3]
b = [8. 4. 0. 18. 0. 0.]
v = 28.


@testset "All Tests" begin
    # test pivot
    @testset "Pivot Tests" begin
        (N′, B′, A′, b′, c′, v′) = pivot(N, B, A, b, c, v, en, lv)
        @test N′ == IntSet([1, 3, 5])
        @test B′ == IntSet([2, 4, 6])
        @test v′ == 12
        #@test b′ == 
        #@test c′ == 
        display(A′)
    end

end
