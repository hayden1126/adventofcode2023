
function day3_1(file::String)::Nothing
    lines = readlines(file)
    n1 = length(lines)
    n2 = length(lines[1])   
    sum = 0

    for (linenum, line) in enumerate(lines)
        for m = eachmatch(r"[0-9]+", line)
            for i = max(1, linenum-1):min(n1, linenum+1)
                a = max(1, m.offset-1)
                b = min(n2, m.offset+length(m.match))

                if occursin(r"[\*/&\+%#@=\$-]", lines[i][a:b]) # true if matches a symbol
                    sum += parse(Int16, m.match)
                    break
                end
            end
        end
    end
    println("Sum: ", sum)
end

function day3_2(file::String)::Nothing
    lines = readlines(file)
    n1 = length(lines)
    n2 = length(lines[1])   
    sum = 0

    for (linenum, line) in enumerate(lines)
        for m = eachmatch(r"\*", line)
            count = 0
            ratio = 1
            for i = max(1, linenum-1):min(n1, linenum+1)
                a = max(1, m.offset-1)
                b = min(n2, m.offset+1)
                
                for n = eachmatch(r"[0-9]+", lines[i][a:b])
                    count += 1
                    # Floodfill
                    left = a + n.offset - 1
                    right = a + n.offset - 1
                    while isdigit(lines[i][left]) && left > 1 && isdigit(lines[i][left-1])
                        left -= 1
                    end
                    while isdigit(lines[i][right]) && right < n2 && isdigit(lines[i][right+1])
                        right += 1
                    end

                    ratio *= parse(Int16, lines[i][left:right])
                end
            end
            sum += count==2 ? ratio : 0
        end
    end
    println("Sum: ", sum)
end

file = "inputs/day3.txt"
@time day3_1(file)
@time day3_2(file)