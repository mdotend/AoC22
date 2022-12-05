using Test
include("day4.jl")

@test getIntervalFromAssignment("1-3") == 1:3
@test fullyContains(1:3, 2:3) == true
@test fullyContains(1:3, 2:5) == false
@test overlaps(1:3, 2:5) == true
@test overlaps(1:3, 3:5) == true
@test overlaps(1:2, 3:5) == false


