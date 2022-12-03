using Test
include("day3.jl")

a, b = getCompartments("vJrwpWtwJgWrhcsFMMfFFhFp")
@test a == "vJrwpWtwJgWr" && b == "hcsFMMfFFhFp"
@test findDoublicate(a,b) == 'p'
@test getPriority('p') == 16
@test getPriority('P') == 42

@test processBagpack("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL") == 38
@test processBagpack("PmmdzqPrVvPwwTWBwg") == 42
@test processBagpack("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn") == 22


@test findBadge("vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg") == 'r'
@test getPriority(findBadge("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn","ttgJtRGJQctTZtZT","CrZsJsPPZsGzwwsLwLmpwMDw")) == 52