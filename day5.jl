
function day5_1(file::String)
    lines = readlines(file)
    seeds = [parse(Int, i) for i = split(lines[1][7:end])]
    mappings = compile(lines[2:end])

    for maps = mappings
        for (index, s) = enumerate(seeds)
            for m = maps
                if (s ≥ m[1] && s ≤ m[2])
                    seeds[index] += m[4]
                    break
                end
            end
        end
    end
    println(minimum(seeds))
end

function compile(lines::Vector{String})::Vector{Vector{Vector{Any}}}
    mappings = Vector{Vector{Vector{Int}}}()
    level = 0
    for line = lines
        if isempty(line)
            push!(mappings, Vector[])
            level += 1
            continue
        elseif !isdigit(line[1])
            continue
        end
        tmp = split(line)
        r = parse(Int, tmp[3])
        b = parse(Int, tmp[1])
        a = parse(Int, tmp[2])
        push!(mappings[level], [a, a+r, b, b-a])        
    end
    return mappings
end

# file = "test.txt"
file = "inputs/day5.txt"
@time day5_1(file)
