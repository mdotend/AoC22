using Test
include("day1.jl")

dummy = Elf()
@test length(dummy.stash) == 0
addSnack!(dummy, 1000)
@test length(dummy.stash) == 1
addSnack!(dummy, 1000)
@test getCals(dummy) == 2000
testElves = Vector{Elf}()
@test reactToInput(Waiting, testElves, "") == Exited
@test reactToInput(Reading, testElves, "") == Waiting
@test reactToInput(Waiting, testElves, "1") == Reading
@test reactToInput(Reading, testElves, "2") == Reading
@test reactToInput(Reading, testElves, "") == Waiting
@test reactToInput(Waiting, testElves, "1") == Reading

@test maximum(map(getCals, testElves)) == 3



# @test getTopThreeCalsLazy([1,2,3,4]) == 9
# test getTopThreeCals([1,2,3,4]) == 9
testVec = rand(Int64,1000000)
@time getTopThreeCals(testVec)
@time getTopThreeCalsLazy(testVec)
