
function day14(file::String; part::Int=1)::Nothing
    lines = readlines(file)
    height, width = length(lines), length(lines[1])
    mapping = Dict{Char, Int8}('.' => 0, 'O' => 1, '#' => 2)
    tmp = [mapping[char] for line in lines for char in line] # 1 -> #, 0 -> .
    platform = transpose(reshape(tmp, width, height))

    if part == 1
        slide!(platform, 'N')
    elseif part == 2
        function cycle!(platform)
            slide!(platform, 'N')
            slide!(platform, 'W')
            slide!(platform, 'S')
            slide!(platform, 'E')
        end
        seen = Set([deepcopy(platform)])
        cycles = [deepcopy(platform)]
        cyclenum = 0
        while cyclenum <= 1000000000
            cyclenum += 1
            cycle!(platform)
            platform in seen && break
            push!(seen, deepcopy(platform))
            push!(cycles, deepcopy(platform))
        end
        cycleend = cyclenum # 10
        cyclestart = findfirst(==(platform), cycles) - 1
        platform = cycles[(1000000000-cyclestart)%(cycleend-cyclestart) + cyclestart+1]
    end
    println(score(platform))
end

function slide!(platform, dir::Char)
    height, width = size(platform)
    dirvec = Dict('N' => (0, -1), 'S' => (0, 1), 'E' => (1, 0), 'W' => (-1, 0))[dir]
    dirrange = Dict('N' => 1:height, 'S' => height:-1:1, 'E' => width:-1:1, 'W' => 1:width)[dir]
    platformcopy = deepcopy(platform)

    if dir in ('N', 'S')
        for y = dirrange
            for x = 1:width
                platform[y, x] != 1 && continue
                x2, y2 = x+dirvec[1], y+dirvec[2]
                !(0 < x2 <= width && 0 < y2 <= height) && continue
                platform[y2, x2] != 0 && continue
                platform[y2, x2], platform[y, x] = platform[y, x], 0
            end
        end
    elseif dir in ('E', 'W')
        for x = dirrange
            for y = 1:height
                platform[y, x] != 1 && continue
                x2, y2 = x+dirvec[1], y+dirvec[2]
                !(0 < x2 <= width && 0 < y2 <= height) && continue
                platform[y2, x2] != 0 && continue
                platform[y2, x2], platform[y, x] = platform[y, x], 0
            end
        end
    end

    platform != platformcopy && slide!(platform, dir)
end

function score(platform)::Int
    score = 0
    height, width = size(platform)
    for y = 1:height
        score += (height-y+1)*count(==(1), platform[y, :])
    end
    return score
end

file = "inputs/day14.txt"
@time day14(file; part=1)
@time day14(file; part=2)