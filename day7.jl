
function day7(file::String; joker::Bool=false)::Nothing
    card_values = Dict(c => Int8(i) for (i, c) = enumerate("AKQJT98765432"))
    # card_values['J'] = joker ? maximum(values(card_values))+1 : card_values['J']
    card_values['J'] = joker ? 14 : 4
    ranked = [Pair{Vector{Int8}, Int}[] for i=1:7]
    hands = Pair{Vector{Int8}, Int}[]
    foreach(line -> push!(hands, Pair([card_values[c] for c = collect(line[1:5])], parse(Int, line[7:end]))), eachline(file))

    for h = hands
        counter_keys = union(h[1])
        counter_vals = Int8[count(==(c), h[1]) for c = counter_keys]

        if joker
            j_index = findfirst(==(14), counter_keys)
            if !isnothing(j_index)
                tmp = counter_vals[j_index]
                counter_vals[j_index] = 0
                counter_vals[argmax(counter_vals)] += tmp
            end
        end

        if 5 in counter_vals
            push!(ranked[1], h)
        elseif 4 in counter_vals
            push!(ranked[2], h)
        elseif 3 in counter_vals
            2 in counter_vals ? push!(ranked[3], h) : push!(ranked[4], h)
        elseif 2 in counter_vals
            count(==(2), counter_vals) == 2 ? push!(ranked[5], h) : push!(ranked[6], h)
        else
            push!(ranked[7], h)
        end
    end
    println(score(length(hands), ranked))
end

function score(rank::Int, ranked::Vector)::Int
    score = 0
    for r in ranked
        for h = sort(r, by=x -> x[1])
            score += h[2]*rank
            rank -= 1
        end
    end
    return score
end

file = "inputs/day7.txt"
@time day7(file)
@time day7(file; joker=true)