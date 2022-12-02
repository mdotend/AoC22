using Test
include("day2.jl")

@test getScore(Scissors, Scissors) == 6
@test getScore(Rock, Paper) == 8
@test getScore(Paper, Rock) == 1

@test translateSecret("A", "Y") == Rock
@test translateSecret("B", "X") == Rock
@test translateSecret("C", "Z") == Rock
