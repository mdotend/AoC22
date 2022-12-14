using Test
include("day8.jl")

grid::Matrix{Int} = Matrix{Int}([3 0 3 7 3; 2 5 5 1 2; 6 5 3 3 2; 3 3 5 4 9; 3 5 3 9 0])
@test isOnEdge(1,1,grid) == true
@test isOnEdge(2,5,grid) == true
@test isOnEdge(2,2,grid) == false

@test isVisible(1, 1, grid) == true
@test isVisible(2, 4, grid) == false
@test getVisibleCount(grid) == 21 

@test getScenicScore(2, 3, grid) == 4
@test getScenicScore(4, 3, grid) == 8

