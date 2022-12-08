abstract type Node end

struct Directory <: Node
    name::String
    parent::Node
    children::Vector{Node}
end

struct File <: Node
    name::String
    parent::Node
    size::Int
end

function isCommand(input::String)
    commandPattern::Regex = r"^\$.*"
    return match(commandPattern, input) != ""
end

function parseCommand!(input::String, workingNode::Node)
    command::Vector{String} = split(input, " ")
    if command[2] == "cd"
        if workingNode.name == ""
            workingNode.Name = command[3]
        end
    end
end