
function day13(file::String; part::Int=1)::Nothing
    sum = 0
    for i = split(read(file, String), "\n\n", keepempty=false)
        image = split(i, '\n', keepempty=false)
        height, width = length(image), length(image[1])
        tmp = [Int8(char == '#' ? 1 : 0) for line in image for char in line] # 1 -> #, 0 -> .
        image = transpose(reshape(tmp, width, height))

        for x = 1:width-1
            sum += ishormirror(image, x, width; part=part) ? x : 0
        end
        for y = 1:height-1
            sum += isvermirror(image, y, height; part=part) ? 100*y : 0
        end
    end
    println(sum)
end

function ishormirror(image, x::Int, width::Int; part::Int=1)::Bool
    n = 0
    if part == 1
        ismirror = true
        while x-n > 0 && x+n < width && ismirror
            ismirror = image[:, x-n] == image[:, x+1+n]
            n += 1
        end
        return ismirror
    elseif part == 2
        smudges = 0
        while x-n > 0 && x+n < width && smudges < 2
            smudges += sum(image[:, x-n] .!= image[:, x+1+n])
            n += 1
        end
        return smudges == 1
    end
end

function isvermirror(image, y::Int, height::Int; part::Int=1)::Bool
    n = 0
    if part == 1
        ismirror = true
        while y-n > 0 && y+n < height && ismirror
            ismirror = image[y-n, :] == image[y+1+n, :]
            n += 1
        end
        return ismirror
    elseif part == 2
        smudges = 0
        while y-n > 0 && y+n < height && smudges < 2
            smudges += sum(image[y-n, :] .!= image[y+1+n, :])
            n += 1
        end
        return smudges == 1
    end
end

file = "inputs/day13.txt"
@time day13(file; part=1)
@time day13(file; part=2)