
function startpos(pipemap::Vector{String})::Tuple{Int, Int}
    for (j, l) = enumerate(pipemap)
        i = findfirst(==('S'), l)
        !isnothing(i) && return (i, j)
    end
end

function day10(file)
    pipemap = readlines(file)

    pipe2vec = Dict(
        '|' => (( 0,-1), ( 0, 1)),
        '-' => ((-1, 0), ( 1, 0)),
        'L' => (( 0,-1), ( 1, 0)),
        'J' => (( 0,-1), (-1, 0)),
        '7' => ((-1, 0), ( 0, 1)),
        'F' => (( 1, 0), ( 0, 1)),
    )

    x, y = startpos(pipemap)
    queue = Tuple[]

    for (dx, dy) = [(-1,0),(1,0),(0,-1),(0,1)]
        pipe = pipemap[y+dy][x+dx]
        !(pipe in keys(pipe2vec)) && continue
        for (dx2, dy2) = pipe2vec[pipe]
            dx == -dx2 && dy == -dy2 && push!(queue, (1, (x+dx, y+dy)))
        end
    end

    dists = Dict((x, y) => 0)

    while !isempty(queue)
        d, (x, y) = popfirst!(queue)
        (x, y) in keys(dists) && continue
        dists[(x, y)] = d

        for (dx, dy) = pipe2vec[pipemap[y][x]]
            push!(queue, (d+1, (x+dx, y+dy)))
        end
    end
    println("Part 1: ", maximum(values(dists)))

    width, height = length(pipemap[1]), length(pipemap)

    area = 0
    for (y, line) = enumerate(pipemap)
        for (x, pipe) = enumerate(line)
            (x, y) in keys(dists) && continue

            crosses = 0
            x2, y2 = x, y

            while x2 < width && y2 < height
                nextpipe = pipemap[y2][x2]
                if (x2, y2) in keys(dists) && !(nextpipe in ['L', '7'])
                    crosses += 1
                end
                x2 += 1
                y2 += 1
            end
            area += crosses%2 == 1 ? 1 : 0
        end
    end
    println("Part 2: ", area)
end

file = "inputs/day10.txt"
@time day10(file)