
function day8_1(file::String)::Nothing
    steps, _, tmp... = readlines(file)
    nodes = Dict(n[1:3] => Pair{String, String}(n[8:10], n[13:15]) for n = tmp)
    println(solve("AAA", steps, nodes; ends="ZZZ"))
end

function day8_2(file::String)::Nothing
    steps, _, tmp... = readlines(file)
    nodes = Dict(n[1:3] => Pair{String, String}(n[8:10], n[13:15]) for n = tmp)
    counters = Int[]
    foreach(start -> push!(counters, solve(start, steps, nodes)), String[n[1] for n = nodes if n[1][end]=='A'])
    println(lcm(counters))
end

function solve(start::String, steps::String, nodes::Dict{String, Pair{String, String}}; ends='Z')::Int
    count = 0
    pointer = start
    while true
        for s = steps
            count += 1
            pointer = s=='L' ? nodes[pointer][1] : nodes[pointer][2]
            endswith(pointer, ends) && return count
        end
    end
end

file = "inputs/day8.txt"
@time day8_1(file)
@time day8_2(file)