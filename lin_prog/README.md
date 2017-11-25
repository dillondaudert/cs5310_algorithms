# Linear Programming in Julia
An implementation of the Simplex algorithm for linear programming in Julia.

## Linear Programming
Given a set of real numbers a_1, a_2, ..., a_n and a set of variables x_1, x_2,
..., x_n, we define a ***linear function*** *f* on those variables by

```julia
f(x_1, x_2, ..., x_n) = a_1*x_1 + a_2*x_2 + ... + a_n*x_n
```

If *b* is a real number and *f* is a linear function, then the equation

```julia
f(x_1, x_2, ..., x_n) = b
```

is a ***linear equality*** and the inequalities

```julia
f(x_1, x_2, ..., x_n) <= b
f(x_1, x_2, ..., x_n) >= b
```

are ***linear inequalities***.

Formally, a **linear-programming problem** is the problem of either maximizing
or minimizing a linear function subject to a finite set of linear constraints 
(equalities or inequalities). In linear programming, strict inequalities are
not allowed.

The linear constraints form a convex feasible region, called a simplex. The 
optimal value of the objective function occurs at a vertex of this region, 
assuming no degenerate conditions.

## The Simplex Algorithm
Takes as input a linear program and returns an optimal solution.

&#9658;
