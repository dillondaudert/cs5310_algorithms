# graph struct and methods tests

using Base.Test
include("../graph.jl")

# Weighted Undirected Graphs
G0_ = (Dict("A" => 1, "B" => 2), [Nullable() Nullable(); Nullable() Nullable()])
G1_ = (Dict("A" => 1, "B" => 2), [0 3; 3 0])
G2_ = (Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4), [0 1 4 3; 1 0 Nullable() 9; 4 Nullable() 0 Nullable(); 3 9 Nullable() 0])


@testset "All Tests" begin
    @testset "Constructor Tests" begin
        @test Graph(Dict(), Array{Real}(0,0)) isa Graph
        @test typeof(Graph(Dict(), Array{Real}(0,0))) <: AbstractGraph
        @test typeof(Graph(G1_...).edges) <: AbstractArray{Nullable}
    end
    # declare some global things
    G0 = Graph(G0_...)
    G1 = Graph(G1_...)
    G2 = Graph(G2_...)   
    @testset "getedge Tests" begin
        for x in eachindex(G1.vertices)
            for y in eachindex(G1.vertices)
                if isnull(getedge(G1, x, y))
                    @test isnull(getedge(G1, x, y)) && isnull(getedge(G1, y, x))
                
                else
                    @test getedge(G1, x, y).value == getedge(G1, y, x).value
                end
            end
        end
        for x in eachindex(G2.vertices)
            for y in eachindex(G2.vertices)
                if isnull(getedge(G2, x, y))
                    @test isnull(getedge(G2, x, y)) && isnull(getedge(G2, y, x))
                
                else
                    @test getedge(G2, x, y).value == getedge(G2, y, x).value
                end
            end
        end
    end
    
    @testset "getadjs Tests" begin
        # 2 nodes 0 edges
        @test isempty(getadjs(G0, "A"))
        # 2 nodes 1 edge
        @test getadjs(G1, "A") == Set(["A", "B"])
        @test getadjs(G1, "B") == Set(["A", "B"])
        # 4 nodes many edges
        @test getadjs(G2, "A") == Set(["A", "B", "C", "D"])
        @test getadjs(G2, "B") == Set(["A", "B", "D"])
        @test getadjs(G2, "C") == Set(["A", "C"])
        @test getadjs(G2, "D") == Set(["A", "B", "D"])
    end

end
