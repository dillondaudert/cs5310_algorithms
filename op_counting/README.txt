Date: 09/13/2017
Class: CS5310
Assignment: Assignment 2
Author: Dillon Daudert

References: 
I used this StackOverflow thread to learn how to iterate over an array and check all items:
https://stackoverflow.com/questions/8015775/check-to-see-if-an-array-is-already-sorted

Explanation of Tests:

Since the functions all operate on an array stored in the object, I decided to put all 
array verification tests when MyAlg.new is called. Then, it can be assumed that the
three algorithms implemented will be operating on a valid array.

In the case of the linear search, if anything but an integer is passed in, an error 
is thrown. Otherwise, either -1 or the result index will be returned.
