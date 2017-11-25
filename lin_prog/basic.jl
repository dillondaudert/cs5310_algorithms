# basic functions

"""
Turn a set of linear constraints in standard form to an equivalent set of 
constraints in slack form.
Return A′, the constraints in slack form
"""
function toslack(A::AbstractArray, b::AbstractArray)
    # create the matrix [b, -A]
    A′ = similar(A, size(A, 1), size(A, 2)+1)
    A′[:, 1] = b
    A′[:, 2:size(A′, 2)] = -A
    return A′
end
