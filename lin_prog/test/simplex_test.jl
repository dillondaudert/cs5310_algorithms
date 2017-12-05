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
A₀ = [1 1 3;
      2 2 5;
      4 1 2]
b₀ = [30 24 36]
c₀ = [3 1 2]

A = [0 0 -1/6 0 -1/6 1/3;
     0 0 8/3 0 2/3 -1/3;
     0 0 0 0 0 0;
     0 0 1/2 0 -1/2 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;]
c = [0 0 -1/6 0 -1/6 -2/3]
b = [8. 4. 0. 18. 0. 0.]
v = 28.
pivA′ = [0 0 0 0 0 0;
      1 0 15/6 0 1/2 0;
      0 0 0 0 0 0;
      0 0 1/2 0 -1/2 0;
      0 0 0 0 0 0;
      3 0 -1/2 0 -1/2 0;]
pivb′ = [0. 12. 0. 18. 0. 24.]
pivc′ = [2 0 -1/2 0 -1/2 0]
pivv′ = 12



@testset "All Tests" begin
    # test pivot
    @testset "Pivot Tests" begin
        (N′, B′, A′, b′, c′, v′) = pivot(N, B, A, b, c, v, en, lv)
        @test N′ == IntSet([1, 3, 5])
        @test B′ == IntSet([2, 4, 6])
        @test A′ == pivA′
        @test v′ == pivv′
        @test b′ == pivb′
        @test c′ == pivc′
    end

    A₂ = [-1/6 -1/6 1/3;
         8/3 2/3 -1/3;
         1/2 -1/2 0;]
    c₂ = [-1/6 -1/6 -2/3]
    b₂ = [8. 4. 18.]
    @testset "Inititalize Simplex Tests" begin
        (N′, B′, A′, b′, c′, v′) = initsimplex(A₂, b₂, c₂)
        @test N′ == IntSet(1:3)
        @test B′ == IntSet(4:6)
        @test b′ == [0. 0. 0. b₂...]
        @test c′ == [c₂... 0. 0. 0.]
        @test v′ == 0
        @testset "First Basic Infeasible Tests" begin
        #    (N′, B′, A′, b′, c′, v′) = initsimplex(A₃, b₃, c₃)
        end
    end

    @testset "Simplex Tests" begin
        @testset "Ex 1" begin
            (N′, B′, A′, b′, c′, v′, x) = simplex(A₀, b₀, c₀)
            @test v′ == v
            @test A′ ≈ A atol=1e-4
            @test N′ == N
            @test B′ == B
            @test b′ ≈ b atol=1e-4
            @test c′ ≈ c atol=1e-4
        end

        # pg. 886
        A₃ = [2 -1;
              1 -5;]
        b₃ = [2 -4]
        c₃ = [2 -1]

        @testset "initsimplex Tests" begin
            (N′, B′, A′, b′, c′, v) = initsimplex(A₃, b₃, c₃)
            initA′ = [0. 0. 0. 0.;
                      -.2 0. 0. -.2;
                      1.8 0. 0. -.2;
                      0. 0. 0. 0.]
            initb′ = [0. .8 2.8 0.]
            initc′ = [1.8 0. 0. -0.2]
            @test N′ == IntSet([1, 4])
            @test B′ == IntSet([2, 3])
            @test A′ ≈ initA′ atol=1e-4
            @test b′ ≈ initb′ atol=1e-4
            @test c′ ≈ initc′ atol=1e-4
        end

        @testset "HW 2" begin
            (N′, B′, A′, b′, c′, v′, x) = simplex(A₃, b₃, c₃)
        end

        A₄ = [-1 1;
              1 3;
              1 -1]
        b₄ = [3. 13. 1.]
        c₄ = [1. 2.]
        trueA′ = [0. 0. 0. 1/4 3/4;
                  0. 0. 0. 1/4 -1/4;
                  0. 0. 0. 0. 1.;
                  0. 0. 0. 0. 0.;
                  0. 0. 0. 0. 0.]
        trueb′ = [4. 3. 4. 0. 0.]
        truec′ = [0. 0. 0. -3/4 -1/4]
        @testset "HW 1" begin
            (N′, B′, A′, b′, c′, v′, x) = simplex(A₄, b₄, c₄)
            @test v′ == 10
            @test N′ == IntSet([4, 5])
            @test B′ == IntSet([1, 2, 3])
            @test A′ ≈ trueA′ atol=1e-4
            @test b′ ≈ trueb′ atol=1e-4
            @test c′ ≈ truec′ atol=1e-4
        end

    end

end
