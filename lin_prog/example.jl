# Example usage of the simplex algorithm for solving linear programs

include("./simplex.jl")
include("./util.jl")

# The following matrices represent two linear programs in standard form
A₁ = [-1 1;
      1 3;
      1 -1]
b₁ = [3 13 1]
c₁ = [1 2]

A₂ = [2 -1;
      1 -5]
b₂ = [2 -4]
c₂ = [2 -1]

# passing these to simplex will return an optimal solution if one exists
(N₁, B₁, A₁′, b₁′, c₁′, v₁, x₁) = simplex(A₁, b₁, c₁)
(N₂, B₂, A₂′, b₂′, c₂′, v₂, x₂) = simplex(A₂, b₂, c₂)

print("Solution to LP 1:\n")
printlp(A₁′, b₁′, c₁′, N₁, B₁, x₁, v₁)
print("Solution to LP 2:\n")
printlp(A₂′, b₂′, c₂′, N₂, B₂, x₂, v₂)
