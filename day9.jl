
function day9_1(file::String)::Nothing
    sum = 0
    for line = eachline(file)
        foreach(l -> sum += l[end], levels(line))
    end
    println(sum)
end

function day9_2(file::String)::Nothing
    sum = 0
    for line = eachline(file)
        for (i, l) = enumerate(levels(line))
            sum += isodd(i) ? l[1] : -l[1]
        end
    end
    println(sum)
end

function levels(line::String)::Vector{Vector{Int}}
    difference(nums::Vector{Int}) = [nums[i+1] - n for (i, n) = enumerate(nums[1:end-1])]
    levels = Vector[[parse(Int, n) for n = split(line)]]
    while !allequal(levels[end])
        push!(levels, difference(levels[end]))
    end
    return levels
end

file = "inputs/day9.txt"
@time day9_1(file)
@time day9_2(file)