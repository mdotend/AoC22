@enum State Waiting Reading Exited
mutable struct Elf
    stash::Vector{Int}
    function Elf()
        new([])
    end
end
function addSnack!(elf::Elf, cals::Int)
    push!(elf.stash, cals)
end

function getCals(elf::Elf)
    return sum(elf.stash)
end

function reactToInput(currentState::State, elves::Vector{Elf}, input::String)
    if currentState == Waiting
        if input == ""
            return Exited
        else
            push!(elves, Elf())
        end
    elseif currentState == Reading && input == ""
        return Waiting
    end
    addSnack!(last(elves), parse(Int64, input))
    return Reading
end

function getTopThreeCals(cals::Vector{Int})
    podium = Vector{Int}()
    for calorie in cals
        if length(podium) == 0
            insert!(podium, 1, calorie)
        else
            for i in 1:minimum([3, length(podium)])
                if podium[i] < calorie
                    insert!(podium, i, calorie)
                    break       
                end
            end
            if length(podium) < 3
                push!(podium, calorie)
            end
        end
    end
    return sum(podium[1:minimum([3, length(podium)])])
end

function getTopThreeCalsLazy(cals::Vector{Int})
    first = maximum(cals)
    second = maximum(filter(n -> n ∉ [first], cals))
    third = maximum(filter(n -> n ∉ [first, second], cals))
    return first+second+third
end

function main()
    readerState::State = Waiting
    elves = Vector{Elf}()

    # println("Enter the stash of calories for each elf; seperate elves with blank line; exit with double blank lines")
    # while readerState != Exited
    #     readerState = reactToInput(readerState, elves, readline())
    # end
    input = readlines("day1_input")
    for snack in input
        readerState = reactToInput(readerState, elves, snack)
    end

    # print("The Elf with the most snacks has " * string(maximum(map(getCals, elves))) * " calories on her.")
    print("The three Elves with the most snacks have " * string(getTopThreeCals(map(getCals, elves))) * " calories combined.")

end

main()