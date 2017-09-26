# Date: 09/22/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 3

using Base.Test
include("../matmul.jl")

mat1 = [1 -1; 2 -2]
mat2 = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]
eye_22 = eye(Int64, 2, 2)
eye_44 = eye(Int64, 4, 4)

@testset "All Tests" begin
    @testset "Invalid Argument Tests" begin
        @test_throws MethodError matmul_rec()
        @test_throws MethodError matmul_rec(mat1, 2)
    end

    # tests relating to mismatched arrays, or improper sizes
    @testset "Improper Array Tests" begin
        @test_throws AssertionError matmul_rec(mat1, [1 2 3 4])
        @test_throws AssertionError matmul_rec(mat1, mat2)
        @test_throws AssertionError matmul_rec(mat1, [1 2 3; 2 2 3; 3 2 3])
        @test_throws AssertionError matmul_rec([], [])
    end

    # tests that should pass
    @testset "Multiply Tests" begin

        @testset "Identity Tests" begin
            @test matmul_rec(mat1, eye_22) == mat1
            @test matmul_rec(eye_22, mat1) == mat1
            @test matmul_rec(mat2, eye_44) == mat2
            @test matmul_rec(eye_44, mat2) == mat2
        end

        @testset "Exponent tests" begin
            @test matmul_rec(mat1, mat1) == mat1^2
            @test matmul_rec(mat2, mat2) == mat2^2
            @test matmul_rec(matmul_rec(mat1, mat1), mat1) == mat1^3
        end

        @testset "Scalar Tests" begin
            @test matmul_rec(3*ones(1,1), 4*ones(1,1)) == 12*ones(1,1)
        end
    end
end
