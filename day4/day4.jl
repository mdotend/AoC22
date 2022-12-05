function getIntervalFromAssignment(assignment::String)
    rule::Regex = r"\d+-\d+"
    if match(rule, assignment) != ""
        (lower::String, upper::String) = split(assignment, '-')
        return parse(Int64, lower):parse(Int64, upper)
    else 
        throw("assignment input does not match pattern")
    end
end

function getIntervalFromAssignment(assignment::SubString)
    return getIntervalFromAssignment(String(assignment))
end



function fullyContains(a::UnitRange, b::UnitRange)
    smaller, bigger = sortRangesByLength(a,b)
    return bigger[1] <= smaller[1] && bigger[end] >= smaller[end]
end

function overlaps(a::UnitRange, b::UnitRange)
    smaller, bigger = sortRangesByLength(a,b)
    return bigger[1] <= smaller[1] && smaller[1] <= bigger[end] || bigger[1] <= smaller[end] && smaller[end] <= bigger[end]
end

function sortRangesByLength(a::UnitRange, b::UnitRange)
    if length(a) < length(b)
        return (a, b)
    else
        return (b, a)
    end
end

function main()
    finalScore::Int = 0
    open("day4/day4_input", "r") do input
        for pair in readlines(input)
            first, second = map(x -> getIntervalFromAssignment(x), collect(split(pair, ",")))
            # if fullyContains(first, second)
            #     finalScore += 1
            # end
            if overlaps(first, second)
                finalScore += 1
            end
        end
    end
    println("The sum of fully duplicate assignments is: " * string(finalScore))
end

main()