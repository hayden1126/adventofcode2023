using Combinatorics
function day11(file::String; emptydistance::Int=2)::Nothing
    lines = readlines(file)
    tmp = [Int8(char == '#' ? 1 : 0) for line in lines for char in line] # 1 -> #, 0 -> .
    spacemap = transpose(reshape(tmp, length(lines[1]), length(lines)))

    empty_rows = [i for i in 1:size(spacemap, 1) if iszero(spacemap[i, :])]
    empty_cols = [j for j in 1:size(spacemap, 2) if iszero(spacemap[:, j])]
    galaxies = [(i, j) for i in 1:size(spacemap, 1), j in 1:size(spacemap, 2) if spacemap[i, j] == 1]

    sum = 0
    for pair = combinations(galaxies, 2)
        sum += abs(pair[1][1] - pair[2][1]) + abs(pair[1][2] - pair[2][2]) +
            (emptydistance-1)*count(n -> min(pair[1][1], pair[2][1]) < n < max(pair[1][1], pair[2][1]), empty_rows) +
            (emptydistance-1)*count(n -> min(pair[1][2], pair[2][2]) < n < max(pair[1][2], pair[2][2]), empty_cols)
    end
    println(sum)
end

file = "inputs/day11.txt"
@time day11(file)
@time day11(file; emptydistance=1000000)