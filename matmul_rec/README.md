Date: 09/19/2017
Author: Dillon Daudert
Assignment: Assignment 3
Class: CS5310

## Overview -
Implement a simple recursive matrix multiply algorithm, using test-driven development.
Include the raw data used for testing, and a short report summarizing the results as 
well as what running time the algorithm is running in.

### Algorithm
Assume only nxn (square) matrices, where n is a power of 2; throw an error otherwise.

### Empirical Testing
Do empirical testing of this algorithm to verify that the running time is O(n^3). 
Consider:
- How to generate test data of various sizes
- How to get the running time 
- How to record the running time
- How to ensure that only the algorithm, and not data generation / IO, are measured

#### Explanation of Tests (bench.jl):
The function time_matmul() times the matmul_rec() function for square matrices of 
sizes 1 <= 2^n <= 512. 

After compiling matmul_rec once (As a consequence of Julia's
JIT compiler, the first run of a function is usually much slower than subsequent 
runs), pairs of random floating point arrays are generated. Each pair is sent as
the arguments of a call to matmul_rec with the @elapsed annotation:

`@elapsed matmul_rec(samples[:,:,1,i], samples[:,:,2,i])`

The elapsed annotation times the execution of the call to matmul_rec. As the samples
are generated ahead of time, the time to allocate and generate each sample does not
factor in to this time. These elapsed times are collected in an array, one array 
for each size of matrix. The means of these are calculated and returned.

### Files
- main.jl: driver script that generates and saves data, runs tests, outputs results
- matmul.jl: contains the matrix multiply algorithm
- bench.jl: contains functions for generating data and timing matmul_rec
- test/matmul_test.jl: contains tests for matrix multiply algorithm
- test/data_test.jl: contains tests for data utility functions
- visual.jl: plot the mean execution time of matmul_rec 
