# graph struct and methods tests

using Base.Test
include("../graph.jl")
include("../paths.jl")

# Weighted Undirected Graphs
G0_ = (Dict("A" => 1, "B" => 2), [Nullable() Nullable(); Nullable() Nullable()])
G1_ = (Dict("A" => 1, "B" => 2), [0 3; 3 0])
G2_ = (Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4), [0 1 4 3; 1 0 Nullable() 9; 4 Nullable() 0 Nullable(); 3 9 Nullable() 0])

G0 = Graph(G0_...)
G1 = Graph(G1_...)
G2 = Graph(G2_...)   

@testset "All Tests" begin
    @testset "dijkstras Tests" begin
        # 2 nodes 0 edges
        @test dijkstra(G0, "A") == [0, Inf]
        @test dijkstra(G0, "B") == [Inf, 0]
        # 2 nodes all connected
        @test dijkstra(G1, "A") == [0, 3]
        @test dijkstra(G1, "B") == [3, 0]
        # 4 nodes with nullables
        @test dijkstra(G2, "A") == [0, 1, 4, 3]
        @test dijkstra(G2, "B") == [1, 0, 5, 4]
        @test dijkstra(G2, "C") == [4, 5, 0, 7]
        @test dijkstra(G2, "D") == [3, 4, 7, 0]

    end

end
