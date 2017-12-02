#"""
#The simplex algorithm and helper functions for linear programming
#"""


"""
Find the optimal solution to a linear program given a set of constraints.
Args
    A - the matrix of constraint coefficients
    b - the vector of constraint values
    c - the vector of objective function coefficients

Return a vector x denoting an optimal solution
"""
function simplex(A, b, c)

end


"""
Take a slack form as input, index lv of leaving variable, index en of entering
variable.
Return the tuple (N′, B′, A′, b′, c′,v′) describing a new slack form.
"""
function pivot(N::IntSet, B::IntSet, A, b, c, v, en::Int, lv::Int)
    # Compute the coefficients of the equation for a new basic variable xₑ
    b[en] = b[lv] / A[lv, en]
    for j ∈ setdiff(N, en)
        A[en, j] = A[lv, j] / A[lv, en]
    end
    A[en, lv] = 1/A[lv, en]

    # Compute the coefficients of the remaining constraints
    for i ∈ setdiff(B, lv)
        b[i] = b[i] - A[i, en]*b[en]
        for j ∈ setdiff(N, en)
            A[i, j] = A[i, j] - A[i, en]*A[en, j]
        end
        A[i, lv] = -A[i, en]*A[en, lv]
    end
    
    # Compute the objective function
    v′ = v + c[en]*b[en]

    for j ∈ setdiff(N, en)
        c[j] = c[j] - c[en]*A[en, j]
    end
    c[lv] = -c[en]*A[en, lv]

    # Compute new sets of basic and nonbasic variables
    N′ = setdiff(N, en) ∪ lv
    B′ = setdiff(B, lv) ∪ en
    return (N′, B′, A, b, c, v′)
end



function initsimplex(A, b, c)

end


