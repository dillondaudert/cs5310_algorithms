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
    A′[n+1:n+m, 1:n] = A
    b′[n+1:n+m] = b
    c′[1:n] = c
    return (A′, b′, c′)
end

"""
Form the auxiliary linear program Lₐ by adding the nonbasic variable x₀.
Set the objective function to -x₀
Return (Lₐ, b, cₐ)
"""
function auxlp(A::AbstractArray, b::AbstractArray, c::AbstractArray)
    Lₐ = fill(-1.0, (size(A, 1), size(A, 2) + 1))
    Lₐ[:, 2:size(Lₐ, 2)] = A
    cₐ = fill(0.0, (1, length(c)+1))
    cₐ[1] = -1
    return (Lₐ, b, cₐ)
end

"""
Print a nicely formatted linear program.
"""
function printlp(A, b, c)
    xᵢ(i) = "x$i"
    print("Maximize ", join((string(round(x, 3), "*", xᵢ(i)) for (i, x) in enumerate(c)), " + "), "\n")
    print("Subject to: \n")
    for row = 1:size(A, 1)
        print(join((string(round(x, 3), "*", xᵢ(j)) for (j, x) in enumerate(A[row, :])), " + "), " ≤ ", string(round(b[row], 3)), "\n")
    end
end

function printlp(A, b, c, N, B, x, v)
    xᵢ(i) = "x$i"
    # create view of submatrix with basic rows, nonbasic columns
    A_ = A[collect(B), collect(N)]
    b_ = b[collect(B)]
    c_ = c[collect(N)]
    lineq(v, V) = join((string(round(x, 3), "*", xᵢ(V[i])) for (i, x) in enumerate(v)), " + ")

    # print nicely
    print("Maximize ", lineq(c_, collect(N)), "\n")
    print("Subject to: \n")
    for row = 1:size(A_, 1)
        print(lineq(A_[row, :], collect(N)), " ≤ ", string(round(b_[row], 3)), "\n")
    end

    print("Optimal solution: z = $(round(v, 3)) when ", join((string(xᵢ(i), " = ", round(d, 3)) for (i, d) in enumerate(x)) , ", "), "\n")
end
