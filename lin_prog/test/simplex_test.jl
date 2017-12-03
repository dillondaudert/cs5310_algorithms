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

A₂ = [-1/6 -1/6 1/3;
     8/3 2/3 -1/3;
     1/2 -1/2 0;]
c₂ = [-1/6 -1/6 -2/3]
b₂ = [8. 4. 18.]

A₃ = [2 -1;
      1 -5;]
b₃ = [2 -4]
c₃ = [2 -1]

@testset "All Tests" begin
    # test pivot
    @testset "Pivot Tests" begin
        (N′, B′, A′, b′, c′, v′) = pivot!(N, B, A, b, c, v, en, lv)
        @test N′ == IntSet([1, 3, 5])
        @test B′ == IntSet([2, 4, 6])
        @test v′ == 12
        #@test b′ == 
        #@test c′ == 
    end

    @testset "Inititalize Simplex Tests" begin
        (N′, B′, A′, b′, c′, v′) = initsimplex(A₂, b₂, c₂)
        @test N′ == IntSet(1:3)
        @test B′ == IntSet(4:6)
        @test b′ == [0. 0. 0. b₂...]
        @test c′ == [c₂... 0. 0. 0.]
        @test v′ == 0
        @testset "First Basic Infeasible Tests" begin
            #(N′, B′, A′, b′, c′, v′) = initsimplex(A₃, b₃, c₃)
            initsimplex(A₃, b₃, c₃)
        end
    end

end
