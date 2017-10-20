# graph struct and methods tests

using Base.Test
include("../graph.jl")

# Weighted Undirected Graphs
G1_ = (Dict("A" => 1, "B" => 2), [Nullable() 3; 3 Nullable()])
G2_ = (Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4), [0 1 4 3; 1 0 Nullable() 9; 4 Nullable() 0 Nullable(); 3 9 Nullable() 0])


@testset "All Tests" begin
    @testset "Constructor Tests" begin
        @test Graph(Dict(), []) isa Graph
        @test typeof(Graph(Dict(), [])) <: AbstractGraph
        @test typeof(Graph(G1_...).Edges) <: AbstractArray{Nullable}
        @test Graph(Dict(), [3.]) isa Graph
    end
    # declare some global things
    G1 = Graph(G1_...)
    G2 = Graph(G2_...)   
    @testset "Method Tests" begin
        @test getedge(G1, "A", "B").value == 3
        @test getedge(G2, "C", "A").value == 4
        @test getedge(G2, "B", "D").value == 9
        for (x, _) ∈ G1.Vertices
            for (y, _) ∈ G1.Vertices
                if isnull(getedge(G1, x, y))
                    @test isnull(getedge(G1, x, y)) && isnull(getedge(G1, y, x))
                
                else
                    @test getedge(G1, x, y).value == getedge(G1, y, x).value
                end
            end
        end
    end
end
