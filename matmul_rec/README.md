Date: 09/19/2017
Author: Dillon Daudert
Assignment: Assignment 3
Class: CS5310

## Overview -
Implement a simple recursive matrix multiply algorithm, using test-driven development.
Include the raw data used for testing, and a short report summarizing the results as 
well as what running time the algorithm is running in.

Assume only nxn (square) matrices, where n is a power of 2; throw an error otherwise.

## Files
- matmul.jl: contains the matrix multiply algorithm
- bench.jl: contains functions for generating data and timing matmul_rec
- test/matmul_test.jl: contains tests for matrix multiply algorithm

## Unit Tests
Run the unit tests by calling `julia test/matmul_test.jl` 


## Empirical Testing
Do empirical testing of this algorithm to verify that the running time is O(n^3). 
Consider:
- How to generate test data of various sizes
- How to get the running time 
- How to record the running time
- How to ensure that only the algorithm, and not data generation / IO, are measured

### Timing matmul_rec() (bench.jl):
The function time_matmul() times the matmul_rec() function for square matrices of 
sizes 2^n, where 0 <= n <= nsamples.

After compiling matmul_rec once (As a consequence of Julia's
JIT compiler, the first run of a function is usually much slower than subsequent 
runs), pairs of random floating point arrays are generated. Each pair is sent as
the arguments of a call to matmul_rec with the @elapsed annotation:

`@elapsed matmul_rec(samples[:,:,1,i], samples[:,:,2,i])`

The elapsed annotation times the execution of the call to matmul_rec. As the samples
are generated ahead of time, the time to allocate and generate each sample does not
factor in to this time. These elapsed times are collected in an array, one array 
for each size of matrix. The means of these are calculated and returned.

### Analyzing the Results
The results of one run of bench.jl are below:

[6.85203e-7, 4.15299e-6, 4.15358e-5, 9.95697e-5, 0.000737527, 0.00554486, 0.0446603, 
0.350661, 2.80905]

