
function compile(lines::Vector{String}; reverse::Bool=false)::Vector{Vector{Vector{Any}}}
    mappings = Vector{Vector{Vector{Int}}}()
    level = 0
    reverse && pushfirst!(lines, "")
    for line = lines
        if isempty(line)
            push!(mappings, Vector[])
            level += 1
            continue
        elseif !isdigit(line[1])
            continue
        end
        tmp = split(line)
        b = parse(Int, tmp[1])
        a = parse(Int, tmp[2])
        r = parse(Int, tmp[3])
        !reverse && push!(mappings[level], [a, a+r-1, b-a])
        reverse && push!(mappings[level], [b, b+r-1, a-b])
    end
    return mappings
end

function day5_1(file::String)::Nothing
    lines = readlines(file)
    seeds = [parse(Int, i) for i = split(lines[1][7:end])]
    mappings = compile(lines[2:end])

    for maps = mappings
        for (index, s) = enumerate(seeds)
            for m = maps
                if (s ≥ m[1] && s ≤ m[2])
                    seeds[index] += m[3]
                    break
                end
            end
        end
    end
    println(minimum(seeds))
end

function day5_2(file::String)::Nothing
    lines = readlines(file)
    seeds = [parse(Int, i) for i = split(lines[1][7:end])]
    mappings = compile(reverse(lines); reverse=true)

    testresult = 0
    found = false
    while !found
        changingval = testresult
        for maps = mappings
            for m = maps
                if (changingval ≥ m[1] && changingval ≤ m[2])
                    changingval += m[3]
                    break
                end
            end
        end
        for (index, s) = enumerate(seeds[1:2:end])
            if (changingval ≥ s && changingval ≤ (s+seeds[index*2]-1))
                println(testresult)
                found = true
                break
            end
        end
        testresult += 1
    end
end

file = "inputs/day5.txt"
@time day5_1(file)
@time day5_2(file)
