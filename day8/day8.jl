function isOnEdge(x::Int, y::Int, grid::Matrix{Int})
    (height, width) = size(grid)
    if x == 1 || x == height
        return true
    elseif y == 1 || y == width
        return true
    end
    return false
end

function isVisibleFromLeft(x::Int, y::Int, grid::Matrix{Int})
    for i in 1:y-1
        if grid[x,y] <= grid[x,i]
            return false
        end
    end
    return true
end

function isVisibleFromRight(x::Int, y::Int, grid::Matrix{Int})
    for i in y+1:size(grid)[2]
        if grid[x,y] <= grid[x,i]
            return false
        end
    end
    return true
end

function isVisibleFromUp(x::Int, y::Int, grid::Matrix{Int})
    for i in 1:x-1
        if grid[x,y] <= grid[i,y]
            return false
        end
    end
    return true
end

function isVisibleFromDown(x::Int, y::Int, grid::Matrix{Int})
    for i in x+1:size(grid)[1]
        if grid[x,y] <= grid[i,y]
            return false
        end
    end
    return true
end

function isVisible(x::Int, y::Int, grid::Matrix{Int})
    if isOnEdge(x, y, grid)
        return true
    end
    if isVisibleFromLeft(x, y, grid)
        return true
    elseif isVisibleFromRight(x, y, grid)
        return true
    elseif isVisibleFromUp(x, y, grid)
        return true
    elseif isVisibleFromDown(x, y, grid)
        return true
    end
    return false
end

function getVisibleCount(grid::Matrix{Int})
    counter::Int = 0
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            if isVisible(i, j, grid)
                counter += 1
            end
        end
    end
    return counter
end

function getLeftScenicScore(x::Int, y::Int, grid::Matrix{Int})
    for i in reverse(1:y-1)
        if grid[x,y] <= grid[x,i]
            return y-i
        end
    end
    return y-1
end

function getRightScenicScore(x::Int, y::Int, grid::Matrix{Int})
    for i in y+1:size(grid)[2]
        if grid[x,y] <= grid[x,i]
            return i-y
        end
    end
    return size(grid)[2]-y
end

function getUpperScenicScore(x::Int, y::Int, grid::Matrix{Int})
    for i in reverse(1:x-1)
        if grid[x,y] <= grid[i,y]
            return x-i
        end
    end
    return x-1
end

function getDownScenicScore(x::Int, y::Int, grid::Matrix{Int})
    for i in x+1:size(grid)[1]
        if grid[x,y] <= grid[i,y]
            return i-x
        end
    end
    return size(grid)[1]-x
end

function getScenicScore(x::Int, y::Int, grid::Matrix{Int})
    return getLeftScenicScore(x, y, grid) * getRightScenicScore(x, y, grid) * getUpperScenicScore(x, y, grid) * getDownScenicScore(x, y, grid)
     
end

function getMaxScenicScore(grid::Matrix{Int})
    maxScore::Int = 0
    for i in 1:size(grid)[1]
        for j in 1:size(grid)[2]
            if isVisible(i, j, grid) && getScenicScore(i,j,grid) > maxScore
                maxScore = getScenicScore(i,j,grid)
            end
        end
    end
    return maxScore
end

function main()
    grid::Matrix{Int} = Matrix{Int}(undef, 0, 0)
    open("day8/day8_input", "r") do input
        rows = readlines(input)
        grid = Matrix{Int}(undef, 0, length(rows[1]))
        for row in rows
            charArray = [i for i in row]
            intArray = map(x -> parse(Int, x), charArray)
            grid = vcat(grid, transpose(intArray))
        end
    end
    print("There are ")
    print(getVisibleCount(grid))
    println(" trees visible")

    print("The best Tree has a scenic score of: ")
    print(getMaxScenicScore(grid))
end
main()