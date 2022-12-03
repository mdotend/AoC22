function getCompartments(bagpack::String)
    seperator::Int = Int(length(bagpack) / 2)
    first::String = bagpack[1:seperator]
    second::String = bagpack[seperator+1:length(bagpack)]
    return first, second
end

function findDoublicate(first::String, second::String)
    for char in first
        if char in second
            return char
        end
    end
    return ' '
end

function getPriority(item::Char)
    code::Int = Int(item)
    if code >= 65 && code <= 90
        return code - 38
    elseif code >= 97 && code <= 122
        return code - 96
    end
    throw("Invalid input")
end

function processBagpack(bagpack::String)
    a::String, b::String = getCompartments(bagpack)
    return getPriority(findDoublicate(a,b))
end

function findBadge(first::String, second::String, third::String)
    duplicates::Vector{Char} = Vector{Char}()
    for char in first
        if char in second
            push!(duplicates, char)
        end
    end
    for char in duplicates
        if char in third
            return char
        end
    end
    return ' '
end

function main()
    finalScore::Int = 0
    open("day3_input", "r") do input
        # for bagpack in readlines(input)
        #     finalScore += processBagpack(bagpack)
        # end
        lineItr = Iterators.Stateful(readlines(input))
        while !isempty(lineItr)
            (a::String, b::String, c::String) = collect(Iterators.take(lineItr, 3))
            finalScore += getPriority(findBadge(a,b,c))
        end
    end
    println("The sum of priorities is: " * string(finalScore))
end
main()