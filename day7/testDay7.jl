using Test
include("day7.jl")

@test isCommand(raw"$ cd /") == true

fileSystem = Directory("")
currentNode::Node = getDirectoryFromCommand!(fileSystem, raw"$ cd /")
@test currentNode.name == "/"
@test length(currentNode.children) == 0
currentNode = getDirectoryFromCommand!(currentNode, raw"$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d")
@test length(currentNode.children) == 4
currentNode = getDirectoryFromCommand!(currentNode, raw"$ cd a")
@test currentNode.name == "a"
currentNode = getDirectoryFromCommand!(currentNode, raw"$ ls
dir e
29116 f
2557 g
62596 h.lst")
@test length(currentNode.children) == 4
currentNode = getDirectoryFromCommand!(currentNode, raw"$ cd ..")
currentNode = getDirectoryFromCommand!(currentNode, raw"$ cd d")
currentNode = getDirectoryFromCommand!(currentNode, raw"$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k")
@test getSize(currentNode) == 24933642