
function day4_1(file::String)::Nothing
    lines = readlines(file)
    sum = 0

    for line = lines
        tmp = split(line, r":|\|")
        wins = length(intersect(split(tmp[2]), split(tmp[3])))
        sum += wins>0 ? 2^(wins-1) : 0
    end
    println(sum)
end

function day4_2(file::String)::Nothing
    lines = readlines(file)
    scores = fill(0, length(lines))
    distribution = fill(1, length(lines))

    for (gamenum, game) = enumerate(lines)
        tmp = split(game, r":|\|")
        scores[gamenum] = length(intersect(split(tmp[2]), split(tmp[3])))
    end

    for (gamenum, s) = enumerate(scores)
        foreach(i -> distribution[i] += distribution[gamenum], gamenum+1:min(gamenum+s, length(scores)))
    end
    println(sum(distribution))
end

file = "inputs/day4.txt"
@time day4_1(file)
@time day4_2(file)