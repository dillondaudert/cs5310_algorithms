# Date: 09/22/2017
# Class: CS 5310
# Author: Dillon Daudert
# Assignment: Assignment 3

function matmul_rec(A::AbstractArray, B::AbstractArray)
    # assert n x n matrix with n == 2^x, x >= 0
    @assert length(size(A)) == length(size(B)) == 2 "Input arrays should have 2 dimensions"
    @assert size(A,1) == size(A,2) == size(B,1) == size(B,2) "Input arrays should be square"
    @assert size(A,1) >= 1 "Input arrays should have size >= 1"
    @assert log2(size(A,1)) == floor(log2(size(A,1))) "Input array sizes should be power of 2"
    # get the number of rows in A (and B)
    n = size(A,1)
    # create a new matrix to hold the result
    C = similar(A, (n, n))
    if n == 1
        # base case
        C[1, 1] = A[1, 1] * B[1, 1]
    else
        # partition the matrices, assuming powers of 2
        half = Int(n/2)
        A_11 = A[1:half, 1:half]
        A_12 = A[1:half, half+1:n]
        A_21 = A[half+1:n, 1:half]
        A_22 = A[half+1:n, half+1:n]
        B_11 = B[1:half, 1:half]
        B_12 = B[1:half, half+1:n]
        B_21 = B[half+1:n, 1:half]
        B_22 = B[half+1:n, half+1:n]
        
        # recursive case
        C[1:half, 1:half] = matmul_rec(A_11, B_11) + matmul_rec(A_12, B_21)
        C[1:half, half+1:n] = matmul_rec(A_11, B_12) + matmul_rec(A_12, B_22)
        C[half+1:n, 1:half] = matmul_rec(A_21, B_11) + matmul_rec(A_22, B_21)
        C[half+1:n, half+1:n] = matmul_rec(A_21, B_12) + matmul_rec(A_22, B_22)    
    end
    
    return C    
end
