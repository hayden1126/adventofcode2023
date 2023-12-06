
function day6_1(file::String)::Nothing
    times, rec_dists = readlines(file)
    races = zip(Int[parse(Int, n) for n = split(times)[2:end]], 
                Int[parse(Int, n) for n = split(rec_dists)[2:end]])
    println(mapreduce(get_range, *, races))
end

function day6_2(file::String)::Nothing
    times, rec_dists = readlines(file)
    timelimit = parse(Int, join(split(times)[2:end]))
    rec_dist = parse(Int, join(split(rec_dists)[2:end]))    
    println(get_range((timelimit, rec_dist)))
end

function get_range(race::Tuple{Int, Int})::Int
    a, b = race[1]÷2, race[1]÷2 + 1 # race is (timelimit, rec_dist)
    while (race[1]-a)*a > race[2]
        a -= 1
    end
    while (race[1]-b)*b > race[2]
        b += 1
    end
    return (b - a - 1)
end

file = "inputs/day6.txt"
@time day6_1(file)
@time day6_2(file)