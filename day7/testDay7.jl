using Test
include("day7.jl")

@test isCommand(raw"$ cd /") == true

currentNode = Node(undef, "")
parseCommand!(raw"$ cd /")
@test currentNode == Node(undef, "/")