function parseStacks(dims::Int, input::Vector{String})
    stacks::Vector{Vector{String}} = Vector{Vector{String}}(undef, dims)
    for i in 1:dims
        stacks[i] = Vector{String}()
    end
    lineItr = Iterators.Stateful(Iterators.reverse(input))
    while !isempty(lineItr)
        cargo = parseCargo(collect(Iterators.take(lineItr, 1))[1])
        for (itr, value) in enumerate(cargo)
            if value != "   "
                insert!(stacks[itr], 1, value)
            end
        end
    end
    return stacks
end

function parseCargo(cargoLine::String)
    output::Vector{SubString} = Vector{SubString}()
    counter::Int = 1
    while counter < length(cargoLine)
        push!(output, SubString(cargoLine, counter, counter+2))
        counter += 4
    end
    return output
end

function parseStep(step::String)
    subString = split(step, " ")
    return (parse(Int16, subString[2]), parse(Int16, subString[4]), parse(Int16, subString[6]))
end

function move!(inputStacks::Vector{Vector{String}}, step::String, keepOrder::Bool=false)
    (amount::Int, source::Int, target::Int) = parseStep(step)
    for i in 1:amount
        cargo =  popfirst!(inputStacks[source])
        if keepOrder
            position = i
        else
            position = 1
        end
        insert!(inputStacks[target], position, cargo)
    end
end

function returnTop(inputStacks::Vector{Vector{String}})
    outString::String = ""
    for stack in inputStacks
        if length(stack) >= 1
            outString *= SubString(stack[1], 2, 2)
        else
            outString *= " "
        end
    end
    return outString
end


function main()
    open("day5/day5_input", "r") do input
        itr = Iterators.Stateful(readlines(input))
        initialStacks::Vector{String} = Vector{String}()
        initState = true
        while initState
            line::String = collect(Iterators.take(itr,1))[1]
            if line != ""
                push!(initialStacks, line)
            else
                initState = false
            end
        end
        dims::Int = length(filter(!isspace, initialStacks[end]))
        cargoStacks = parseStacks(dims, initialStacks[1:end-1])
        for command in itr
            # move!(cargoStacks, command)
            move!(cargoStacks, command, true)
        end
        println(returnTop(cargoStacks))
    end
end
main()