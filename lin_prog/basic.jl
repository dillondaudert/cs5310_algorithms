# basic functions

"""
Expand a linear program in matrix form to include m = length(b) slack
variables. The slack variables are assumed to have indices n+1, n+2, ..., n+m.
Return (A′, b′, c′), the 
"""
function expandlp(A::AbstractArray, b::AbstractArray, c::AbstractArray)
    n = length(c) # number of nonbasic vars
    m = length(b) # number of basic vars
    A′ = fill(0.0, (n+m, n+m))
    b′ = fill(0.0, (1, n+m))
    c′ = fill(0.0, (1, n+m))
    A′[1:m, 1:n] = A
    b′[1:m] = b
    c′[1:n] = c
    return (A′, b′, c′)
end
