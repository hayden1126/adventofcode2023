
function day2_1(file::String, r::Int, g::Int, b::Int)::Nothing
    lines = readlines(file)
    sum = 0

    for (game_id, game) = enumerate(lines)
      dq = false
      rnds = split(game, r"[:;]")[2:end]
      for rd = rnds
        colors = split(rd, ',')
        for tmp = colors
          c = strip(tmp)
          dq = (occursin("red", c) && parse(Int16, c[1:2]) > r) || (occursin("green", c) && parse(Int16, c[1:2]) > g) || (occursin("blue", c) && parse(Int16, c[1:2]) > b)
          dq && @goto p
        end
      end
      @label p
      sum += !dq ? game_id : 0
    end
  
    println(sum)
  end
  
  function day2_2(file::String)::Nothing
    lines = readlines(file)
    mult_sum = 0
  
    for game = lines
      cubes = Int16[0, 0, 0]
      rnds = split(game, r"[:;]")[2:end]
      for rd = rnds
        colors = split(rd, ',')
        for c = colors
          n = parse(Int16, strip(c)[1:2])
          if occursin("red", c)
            cubes[1] = max(n, cubes[1])
          elseif occursin("green", c)
            cubes[2] = max(n, cubes[2])
          elseif occursin("blue", c)
            cubes[3] = max(n, cubes[3])
          end
        end
      end
      mult_sum += prod(cubes)
    end
  
    println(mult_sum)
  end

  file = "inputs/day2.txt"
  @time day2_1(file, 12, 13, 14)
  @time day2_2(file)