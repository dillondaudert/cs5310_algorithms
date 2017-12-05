#"""
#The simplex algorithm and helper functions for linear programming
#"""
using Base.Test
include("./util.jl")


"""
Find the optimal solution to a linear program given a set of constraints.
Args
    A - the matrix of constraint coefficients
    b - the vector of constraint values
    c - the vector of objective function coefficients

Return the slack form linear program and a vector x denoting an optimal solution as a tuple:
(N′, B′, A′, b′, c′, v)
"""
function simplex(A_, b_, c_)
    (N, B, A, b, c, v) = initsimplex(A_, b_, c_)
    if N == Inf || N == -1
        # either infeasible or unbounded
        return (N, B, A, b, c, v)
    end
    return _innersimplex(N, B, A, b, c, v)
end

"""
Turn a linear program in standard form into a linear program in slack form,
where the first basic solution is feasible.
Return a slack form tuple (N, B, A, b, c, v) or (-1, -1, -1, -1, -1, -1) if
no feasible solution exists.
"""
function initsimplex(A, b, c)
    # implicitly test the basic solution to the initial slack form
    n = length(c) # number of nonbasic vars
    m = length(b) # number of basic vars
    k = indmin(b)
    if b[k] ≥ 0
        # the initial solution is feasible
        N = IntSet(1:n)
        B = IntSet(n+1:n+m)
        # expand to slack form
        (A′, b′, c′) = expandlp(A, b, c)
        return (N, B, A′, b′, c′, 0)
    end

    # form Lₐ by adding -x₀ to the left-hand side of each constraint and 
    # setting obj function to -x₀
    # Since Julia is 1-index, this has the effect of adding 1 to all 
    # variable indices
    Lₐ, bₐ, cₐ = auxlp(A, b, c)
    Lₐ, bₐ, cₐ = expandlp(Lₐ, bₐ, cₐ)
    N = IntSet(1:n+1) #Lₐ has n+1 nonbasic variables
    B = IntSet(n+2:n+m+1)
    # Pivot the new nonbasic variable with the basic variable with 
    # the largest negative value in b
    lv = n + k + 1
    en = 1
    v = 0
    (N, B, Lₐ, bₐ, cₐ, v) = pivot(N, B, Lₐ, bₐ, cₐ, v, en, lv)
    # the basic solution is now feasible for Lₐ
    @test minimum(bₐ[[i for i ∈ B]]) ≥ 0
    @test length(N) == n+1
    @test length(B) == m

    # Find optimal solution to Lₐ
    (N′, B′, Lₐ, bₐ, cₐ, v, x) = _innersimplex(N, B, Lₐ, bₐ, cₐ, v)

    # if this solution sets x₁ == 0
    if x[1] == 0.
        # if basic, make nonbasic
        if 1 ∈ B′
            (N′, B′, Lₐ, bₐ, cₐ, v) = degeneratepivot(N′, B′, A′, Lₐ, bₐ, cₐ, 1)
        end
        
        # drop all x₁ terms from this solution and restore original objective
        # function for L
        A′ = Lₐ[2:size(Lₐ, 1), 2:size(Lₐ, 2)] 
        b′ = reshape(bₐ[2:length(bₐ)], (1, n+m))
        c′ = fill(0.0, (1, n+m))
        c′[1:n] = c
        # remove 1 from nonbasics, decrement others
        N′ = setdiff(N′, 1)
        N′ = IntSet([i-1 for i ∈ N′])
        B′ = IntSet([i-1 for i ∈ B′])

        # the original nonbasic variables were the first 1:n variables
        N⁰ = IntSet(1:n)

        # some terms in the original obj function may now be basic. for each
        # of these, replace it by the right-hand side of its associated 
        # constraint
        # this is the same as adding the appropriate A row to c and multiplying by the coeff
        # c += c[basic]*A[basic, :]

        # find the original nonbasic vars that are now basic in solution
        swaps = N⁰ ∩ B′
        for basic ∈ swaps
            # replace the basic variables with their constraint values in c
            c′ -= reshape(c′[basic] * A′[basic, :], (1, length(c′)))
            c′[basic] = 0.0
        end
        
        # return modified final slack form
        return (N′, B′, A′, b′, c′, 0)
    end

    return (-1, -1, -1, -1, -1, -1)
end


"""
Perform the interior pivot loop for simplex()
Return the resulting linear pogram and the optimal solution x. 
If solution is unbounded, return (Inf, Inf, Inf, Inf, Inf, Inf, Inf).
"""
function _innersimplex(N, B, A, b, c, v)
    # find index of nonbasic var with positive coef in c
    N⁺ = IntSet(find([j > 0 for j in c]))
    # while some index has cⱼ > 0
    while length(N⁺) > 0
        Δ = fill(Inf, (1, length(b)))
        # choose index e for which cₑ > 0
        en = pop!(N⁺)
        # find how much each basic variable constrains xₑ
        for i ∈ B
            if A[i, en] > 0
                Δ[i] = b[i] / A[i, en]
            end
        end
        # choose an index l that minimizes Δᵢ
        lv = indmin(Δ)
        if Δ[lv] == Inf
            return (Inf, Inf, Inf, Inf, Inf, Inf, Inf)
        else
            # swap basic and nonbasic variable
            (N, B, A, b, c, v) = pivot(N, B, A, b, c, v, en, lv)
        end
        N⁺ = IntSet(find([j > 0 for j in c]))
    end

    x = fill(0.0, (1, length(b)))
    for i ∈ B
        x[i] = b[i]
    end

    return (N, B, A, b, c, v, x)
end


"""
Take a slack form as input, index lv of leaving variable, index en of entering
variable.
Return the tuple (N′, B′, A′, b′, c′,v′) describing a new slack form.
"""
function pivot(N::IntSet, B::IntSet, A, b, c, v, en::Int, lv::Int)
    A′ = fill(0.0, size(A))
    b′ = fill(0.0, size(b))
    c′ = fill(0.0, size(c))
    # Compute the coefficients of the equation for a new basic variable xₑ
    b′[en] = b[lv] / A[lv, en]
    for j ∈ setdiff(N, en)
        A′[en, j] = A[lv, j] / A[lv, en]
    end
    A′[en, lv] = 1/A[lv, en]

    # Compute the coefficients of the remaining constraints
    for i ∈ setdiff(B, lv)
        b′[i] = b[i] - A[i, en]*b′[en]
        for j ∈ setdiff(N, en)
            A′[i, j] = A[i, j] - A[i, en]*A′[en, j]
        end
        A′[i, lv] = -A[i, en]*A′[en, lv]
    end
    
    # Compute the objective function
    v′ = v + c[en]*b′[en]

    for j ∈ setdiff(N, en)
        c′[j] = c[j] - c[en]*A′[en, j]
    end
    c′[lv] = -c[en]*A′[en, lv]

    # Compute new sets of basic and nonbasic variables
    N′ = union(setdiff(N, en), lv)
    B′ = union(setdiff(B, lv), en)
    return (N′, B′, A′, b′, c′, v′)
end

"""
Given a slack form linear program and a varible we want to make nonbasic (lv),
perform a degenerate pivot. Find nonbasic variable en such that v does not
change.
Return equivalent slack form.
"""
function degeneratepivot(N::IntSet, B::IntSet, A, b, c, v, lv::Int)
    for en ∈ N
        bₑ = b[lv] / A[lv, en]
        v′ = v + c[en]*bₑ
        # b[en] = b[lv] / A[lv, en]
        # v′ = v + c[en]*b[en]
        if v == v′
            @printf("Performing degenerate pivot with en = %d, lv = %d\n", en, lv)
            return pivot(N, B, A, b, c, v, en, lv)
        end
    end
    @printf("No degenerate pivot found!\n")
    return (N, B, A, b, c, v)
end




