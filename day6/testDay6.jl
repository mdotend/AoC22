using Test
include("day6.jl")

@test getMarkerPosition("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
@test getMarkerPosition("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
@test getMarkerPosition("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14) == 19