"""
The simplex algorithm and helper functions for linear programming
"""
module Simplex


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
Return the tuple (N̂ , B̂ , Â , b̂ , ĉ , v̂ ) describing a new slack form.
"""
function pivot(N::IntSet, B::IntSet, A, b, c, v, lv::Int, en::Int)
    # Compute the coefficients of the equation for a new basic variable xₑ
    ̂A

end



function initsimplex(A, b, c)

end


end
