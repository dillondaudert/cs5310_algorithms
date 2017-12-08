# Dekker's Algorithm
An implementation of Dekker's algorithm for mutual exclusion in C.

## Overview
Dekker's algorithm only works for 2 threads. One thread continually prints 'c',
the other prints 's'. Each time a thread prints a character, it should update
a character counter. Since each thread updates the same counter, access to the
counter should be controlled via a critical section. 

After 30 characters have been printed, the next thread should print a new line
and set the character counter to 0.

## Compilation
`gcc -std=c99 -pthread -Wall peters.c -o <executable_name>`

## Warning
None

## References
man pthreads
man usleep
[Dekker's Algorithm](https://wikipedia.org/wiki/Dekker%27s_algorithm)
