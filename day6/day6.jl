function getMarkerPosition(dataStream::String, distinctChar::Int = 4)
    buffer::Vector{Char} = Vector{Char}(undef, distinctChar)
    for position in eachindex(dataStream)
        buffer[(position%distinctChar)+1] = dataStream[position]
        if position >= distinctChar && length(unique(buffer)) == distinctChar
            return position
        end
    end
    throw("No start signal found")
end

function main()
    open("day6/day6_input", "r") do input
        stream::String = read(input, String)
        #println(getMarkerPosition(stream))
        println(getMarkerPosition(stream, 14))
    end
end

main()