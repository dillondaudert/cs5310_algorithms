# Linear Programming in Julia
An implementation of the Simplex algorithm for linear programming in Julia.

## Linear Programming
Given a set of real numbers a_1, a_2, ..., a_n and a set of variables x_1, x_2,
..., x_n, we define a ***linear function*** *f* on those variables by

```julia
f(x\_1, x_2, ..., x_n) = a_1*x_1 + a_2*x_2 + ... + a_n*x_n
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

### Standard and Slack Forms
In standard form, all the constraints are inequalities, whereas in the slack 
form, all the constraints are equalities except for those that require variables
to be nonnegative.

## The Simplex Algorithm
Takes as input a linear program and returns an optimal solution. For this
algorithm, we will express the linear program in slack form, so we convert
the constraints (besides the nonnegativity constraints) into equalities:

Let `f(x\_1, x_2, ..., x_n) = a_1*x_1 + a_2*x_2 + ... + a_n*x_n <= b` be an 
inequality constraint. We introduce a new variable *s* and rewrite the 
inequality as the two constraints:

```julia
s = b - a_1*x_1 + a_2*x_2 + ... + a_n*x_n
s >= 0
```

We call *s* the ***slack variable***  because it measures the difference between
the left-hand and right-hand sides of the inequality. When converting to slack 
form, we refer to *s* as *x_(n+1)* to denote the slack variable associated with
the *i*th inequality.

At each iteration:
- Find a basic solution: set each nonbasic variable to 0 and compute the values 
of the basic variables from the equality constraints
- Choose a nonbasic variable such that increasing that variable from 0 also 
increases the objective function
- Increase this nonbasic variable until some other basic variable becomes 0
- Rewrite the slack form, exchanging the roles of that basic variable and the
chosen nonbasic variable

&#9658;
