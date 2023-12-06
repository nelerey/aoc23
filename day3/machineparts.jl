# notes
# there is a difference between "str" and 'str'
# pushfirst, push, *
# dict comprehension, list comprehension with conditionals

filepath = joinpath(@__DIR__, "input.txt")

function paddots(text)
    llen = length(text[1])
    topbot = repeat(".", llen + 3)  # buffer for possible nasty $$
    pushfirst!(push!(text, topbot), topbot)  # modified in place! 
    for (l, line) in enumerate(text)
        text[l] = "." * line * "."
    end
    return text
end

function part12(lines)
    numsum=0
    asterisk_ijlocs = ["$i,$(m.offset)" for (i, line) in enumerate(lines) for m in eachmatch(r"\*", line)]
    println(asterisk_ijlocs)

    nums_adjacent = Dict(a => [] for a in asterisk_ijlocs)

    for (i, line) in enumerate(lines[2:end-1])
        println("line $i")
        nummatches = eachmatch(r"\d+", line)
        for m in nummatches
            num = m.match
            ln = length(num)
            j = m.offset
            # make string of the characters surrounding the number: left x right x top x bottom
            surrounds = line[j-1] * line[j+ln] * lines[i][j-1:j+ln] * lines[i+2][j-1:j+ln]
            # if their surroundings are not all dots, add to sum
            if !all(isequal('.'), surrounds)
                numsum += parse(Int64, num)
            end

            # part 2: if there's an asterisk in the number's surroundings, assign the number to the asterisk location
            asterisk_locs_surrounds = [m.offset for m in eachmatch(r"\*", surrounds)]
            for a in asterisk_locs_surrounds
                orig_astrk_iloc = i + (a <= 2) + 2*(a > (ln + 4)) 
                orig_astrk_jloc = j + (a == 1 ? -1 : (a == 2 ? ln : mod(a-3, ln+2)-1)) #wrong: j + (if a == 1 -1 elseif a == 2 ln else mod(a-3, ln+2)-1 end)
                
                aijloc="$orig_astrk_iloc,$orig_astrk_jloc"
                println("a: $a, i: $i, j: $j, ln: $ln, num: $num")
                println(" --> $orig_astrk_iloc, $orig_astrk_jloc")
                println("a == 1 gives ", a == 1)
                nums_adjacent[aijloc] = push!(nums_adjacent[aijloc], parse(Int64, num))
            end
        end
    end
    gearratios = [prod(val) for (key, val) in nums_adjacent if length(val) == 2]
    gearratiosum = sum(gearratios)
    return numsum, gearratiosum
end

if abspath(PROGRAM_FILE) == @__FILE__   # if __name__ == "main"
    lines = readlines(filepath)
    lines = paddots(lines)

    result_p1, result_p2 = part12(lines)

    print("Result part 1: $result_p1")
    print("Result part 2: $result_p2")

end