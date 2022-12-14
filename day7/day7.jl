abstract type Node end

mutable struct Directory <: Node
    name::String
    parent::Node
    children::Vector{Node}
    Directory(name::String) = (dir = new(); dir.name = name; dir.children = Vector{Node}(); dir)
    Directory(name::String, parent::Node) = (dir = new(); dir.name = name; dir.parent = parent; dir.children = Vector{Node}(); dir)
    Directory(name::String, parent::Node, children::Vector{Node}) = new(name, parent, children)
end

struct File <: Node
    name::String
    parent::Node
    size::Int
end

function getParent(node::Node)
    return node.parent
end

function isCommand(input::String)
    commandPattern::Regex = r"^\$.*"
    return match(commandPattern, input) != ""
end

function getDirectoryFromCommand!(workingNode::Directory, input::String)
    return getDirectoryFromCommand!(workingNode, [input])
end

function getDirectoryFromCommand!(workingNode::Directory, input::Vector{String})
    command::Vector{String} = split(input[1], " ")
    if command[2] == "cd"
        if workingNode.name == ""
            workingNode.name = command[3]
        end
        if command[3] == "/"
            while workingNode.name != "/"
                workingNode = getParent(workingNode)
            end
        elseif command[3] == ".."
            return getParent(workingNode)
        else
            for child in workingNode.children
                if child.name == command[3]
                    return child
                end
            end
            throw("Directory " * command[3] * " not found")
        end
    elseif command[2] == "ls"
        for line in input[2:end]
            (first::String, second::String) = split(line, " ", limit=2)
            if first == "dir"
                push!(workingNode.children, Directory(second, workingNode))
            else
                push!(workingNode.children, File(second, workingNode, parse(Int, first)))
            end
        end
    end
    return workingNode
end

function getSize(dir::Directory)
    size::Int = 0
    for child in dir.children
        size += getSize(child)
    end
    return size
end

function getSize(file::File)
    return file.size
end

function main()
    fileSystem::Directory = Directory("")
    open("day7/day7_input.txt", "r") do input
        currentNode = currentNode::Node = getDirectoryFromCommand!(fileSystem, raw"$ cd /")
        commandInput = readlines(input)
        counter::Int = 2
        while counter <= length(commandInput)
            commands::Vector{String} = Vector{String}()
            if isCommand(commandInput[counter])
                push!(commands, commandInput[counter])
                counter += 1
                if occursin("ls ", commands[1])
                    while !isCommand(commandInput[counter])
                        push!(commands, commandInput[counter])
                        counter += 1
                    end
                end
                currentNode = getDirectoryFromCommand!(currentNode, commands)
            end
        end
    end
end
#main()