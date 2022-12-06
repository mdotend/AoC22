using Test

include("day5.jl")

@test parseCargo("    [D]    ") == ["   ", "[D]", "   "]

testStack::Vector{Vector{String}} = [["[N]", "[Z]"], ["[D]", "[C]", "[M]"], ["[P]"]]
parsedStack = parseStacks(3, ["    [D]    ", "[N] [C]    ", "[Z] [M] [P]"] )
@test parsedStack == testStack
move!(parsedStack, "move 1 from 2 to 1")
@test parsedStack == [["[D]", "[N]", "[Z]"], ["[C]", "[M]"], ["[P]"]]
move!(parsedStack, "move 3 from 1 to 3")
@test parsedStack == [[], ["[C]", "[M]"], ["[Z]", "[N]", "[D]", "[P]"]]
move!(parsedStack, "move 2 from 2 to 1")
@test parsedStack == [["[M]", "[C]"], [], ["[Z]", "[N]", "[D]", "[P]"]]
@test returnTop(parsedStack) == "M Z"

newParsedStack = parseStacks(3, ["    [D]    ", "[N] [C]    ", "[Z] [M] [P]"] )
move!(newParsedStack, "move 1 from 2 to 1", true)
@test newParsedStack == [["[D]", "[N]", "[Z]"], ["[C]", "[M]"], ["[P]"]]
move!(newParsedStack, "move 3 from 1 to 3", true)
@test newParsedStack == [[], ["[C]", "[M]"], ["[D]", "[N]", "[Z]", "[P]"]]
