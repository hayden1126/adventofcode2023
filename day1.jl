
function day1_1(file::String)::Nothing
    lines = readlines(file)
    
    sum = 0
    regex = r"\d"
    
    for line = lines
      fst = match(regex, line).match
      lst = match(regex, reverse(line)).match
      sum += parse(Int8, fst)*10 + parse(Int8, lst)
    end
    println(sum)
  end
  
  function day1_2(file::String)::Nothing
    lines = readlines(file)
   
    sum = 0
    regex = r"one|two|three|four|five|six|seven|eight|nine|\d"
    regex_rev = r"enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|\d"
    mapping = Dict("one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9)
    
    for line = lines
      fst = match(regex, line).match
      lst = reverse(match(regex_rev, reverse(line)).match)
      fst_d = haskey(mapping, fst) ? mapping[fst] : parse(Int8, fst)
      lst_d = haskey(mapping, lst) ? mapping[lst] : parse(Int8, lst)
      sum += fst_d*10 + lst_d
    end

    println(sum)
  end
  
file = "inputs/day1.txt"
@time day1_1(file)
@time day1_2(file)