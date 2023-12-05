# read file contents, one line at a time 
home = dirname(@__FILE__)
filepath = joinpath(home, "input.txt")

function extract_number(line::String)
    # get first digit
    cnum_1 = -1
    i = 1
    while cnum_1 == -1
        c = line[i]
        if isdigit(c)
            cnum_1 = parse(Int64, c)
        end
        i += 1
    end

    # get the final digit
    cnum_2 = -1
    for c in line
        if isdigit(c)
            cnum_2 = parse(Int64, c)
        end
    end

    return 10*cnum_1 + cnum_2
end


function parse_spelled_numbers(line::String)
    spell2num_nastymf = Dict("oneight"=>"18", "threeight"=>"38", "fiveight"=>"58", "nineight"=>"98",
                              "eightwo" => "82", "eighthree" => "83",
                              "twone" => "21")
    spell2num = Dict("one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5",
                     "six"=>"6", "seven"=>"7", "eight"=>"8", "nine"=>"9")
    
    line_allnum = line
    for (key,val) in spell2num_nastymf
        line_allnum = replace(line, key=>val)
    end
    for (key,val) in spell2num
        line_allnum = replace(line_allnum, key=>val)
    end
    return line_allnum
end

if abspath(PROGRAM_FILE) == @__FILE__ is true
    open(filepath) do f
        cali_sum_a = cali_sum_b = 0
        line = 0  

        # read till end of file
        while ! eof(f)  
    
            # read a new / next line for every iteration           
            s = readline(f)          
            line += 1

            # convert spelled-out numbers to digits for TASK 2
            s_allnum = parse_spelled_numbers(s)
            
            # extract numbers
            num_a = extract_number(s)
            num_b = extract_number(s_allnum)

            # TASK 1
            cali_sum_a += num_a
            # TASK 2
            cali_sum_b += num_b
        end
        println("The sum of the calibration numbers without conversion is $cali_sum_a")
        println("The sum of the calibration numbers after conversion is $cali_sum_b")
    end
end