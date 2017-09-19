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

### Files
- main.rb: driver script that generates and saves data, runs tests, outputs results
- matmul.rb: contains the matrix multiply algorithm
- data.rb: contains functions for generating, saving, and loading test data
- spec/matmul_spec.rb: contains tests for matrix multiply algorithm
- spec/data_spec.rb: contains tests for data utility functions
