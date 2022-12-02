@enum Choice Rock = 1 Paper = 2 Scissors = 3

function won(a::Choice, b::Choice)
    if (a == Rock && b == Paper)|| (a == Paper && b == Scissors) || (a == Scissors && b == Rock)
        return true
    end
    return false
end

function getScore(a::Choice, b::Choice)
    score::Int = 0
    if a == b
        score = 3
    else
        if won(a,b)
            score = 6 
        end
    end
    return score + Int(b)
end

function translateChoice(input::String)
    if input == "A"
        return Rock
    elseif input == "B"
        return Paper
    elseif input == "C"
        return Scissors
    else
        throw("Something went wrong")
    end
end

function translateSecret(first::String, mode::String)
    if mode == "X" # loose
        if translateChoice(first) == Rock 
            return Scissors
        elseif translateChoice(first) == Paper
            return Rock
        else
            return Paper
        end
    elseif mode == "Y" # draw
        return translateChoice(first)
    elseif mode == "Z" # win
            if translateChoice(first) == Rock 
                return Paper
            elseif translateChoice(first) == Paper
                return Scissors
            else
                return Rock
            end
    else
        throw("Something went wrong")
    end  
end

function main()
    finalScore::Int = 0
    open("day2_input", "r") do input
        for match in readlines(input)
            a::String, b::String = split(match, " ", limit=2)
            finalScore += getScore(translateChoice(a),translateSecret(a,b))
        end
    end
    println("The final score is: " * string(finalScore))
end

main()