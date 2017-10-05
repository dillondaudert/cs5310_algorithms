"""
A simple implementation of quicksort in Julia.
Worst-case Time: O(n²)
Best-case Time: O(n lg n)
Average-case Time: θ(n lg n)
"""

module MyQuicksort

export Quicksort!, RandomizedQuicksort!

function Quicksort!(A::AbstractArray, p, r)
    "Quicksort takes an array and sorts it in-place."
    if p < r
        q = Partition(A, p, r)
        Quicksort!(A, p, q-1)
        Quicksort!(A, q+1, r)
    end
end

function RandomizedQuicksort!(A, p, r)
    "Randomized version of quicksort"
    if p < r
        q = RandomizedPartition(A, p, r)
        RandomizedQuicksort!(A, p, q-1)
        RandomizedQuicksort!(A, q+1, r)
    end
end

function Partition(A::AbstractArray, p, r)
    "Partition splits A into 2 partitions, where the elements A[k] ≤ A[r] 
    are found to the right of r, and those larger are found to the left.
    Returns the index of the pivot."

    x = A[r]
    i = p-1
    for j in p:(r-1)
        # assert loop invariant
        if A[j] ≤ x
            i += 1
            # exchange A[i] with A[j]
            tmp = A[i]
            A[i] = A[j]
            A[j] = tmp
        end
    end
    # exchange A[i + 1] with A[r]
    A[r] = A[i+1]
    A[i+1] = x
    return i+1
end

function RandomizedPartition(A, p, r)
    i = rand(p:r)
    # exchange randomly sampled element with r
    tmp = A[r]
    A[r] = A[i]
    A[i] = tmp
    return Partition(A, p, r)
end

end
