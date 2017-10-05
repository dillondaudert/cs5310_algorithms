# bubble sort in Julia

function bubble_sort(A::AbstractArray)
    for i = 1:(length(A)-1)
        for j = length(A):-1:(i+1) 
            if A[j-1] > A[j]
                tmp = A[j-1]
                A[j-1] = A[j]
                A[j] = tmp
            end
        end
    end
    return A
end
