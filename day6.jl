
function day6_1(file::String)::Nothing
    times, rec_dists = readlines(file)
    races = zip(Int32[parse(Int32, n) for n = split(times)[2:end]], 
                Int32[parse(Int32, n) for n = split(rec_dists)[2:end]])
    sum = 1

    for (timelimit, rec_dist) = races
        bounds = Int32[timelimit÷2, timelimit÷2 + 1] # number of milliseconds charging
        while (timelimit-bounds[1])*bounds[1] > rec_dist
            bounds[1] -= 1
        end
        while (timelimit-bounds[2])*bounds[2] > rec_dist
            bounds[2] += 1
        end
        sum *= (bounds[2] - bounds[1] - 1)
    end

    println(sum)
end

function day6_2(file::String)::Nothing
    times, rec_dists = readlines(file)
    timelimit = parse(Int, join(split(times)[2:end]))
    rec_dist = parse(Int, join(split(rec_dists)[2:end]))

    bounds = Int32[timelimit÷2, timelimit÷2 + 1] # number of milliseconds charging 
    while (timelimit-bounds[1])*bounds[1] > rec_dist
        bounds[1] -= 1
    end
    while (timelimit-bounds[2])*bounds[2] > rec_dist
        bounds[2] += 1
    end

    sum = (bounds[2] - bounds[1] - 1)
    println(sum)
end

file = "inputs/day6.txt"
@time day6_1(file)
@time day6_2(file)