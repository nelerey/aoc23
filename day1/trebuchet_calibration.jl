# read file contents, one line at a time 
home = dirname(@__FILE__)
filepath = joinpath(home, "input.txt")

open(filepath) do f

    cali_sum_a = 0
    cali_sum_b = 0

    # line_number
    line = 0  
   
    # read till end of file
    while ! eof(f)  
   
        # read a new / next line for every iteration           
        s = readline(f)          
        line += 1

        # convert spelled-out numbers to digits for TASK 2
        spell2num_nastymf = Dict("oneight"=>"18", "threeight"=>"38", "fiveight"=>"58", "nineight"=>"98",
                                 "eightwo" => "82", "eighthree" => "83",
                                 "twone" => "21")
        spell2num = Dict("one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5",
                         "six"=>"6", "seven"=>"7", "eight"=>"8", "nine"=>"9")
        # this does not take into account "zoneight
        s_allnum = s
        for (key,val) in spell2num_nastymf
            s_allnum = replace(s_allnum, key=>val)
        end
        for (key,val) in spell2num
            s_allnum = replace(s_allnum, key=>val)
        end

        # get the first digit
        cnum_1_a = -1
        i = 1
        while cnum_1_a == -1
            c = s[i]
            if isdigit(c)
                cnum_1_a = parse(Int64, c)
            end
            i += 1
        end

        cnum_1_b = -1
        i = 1
        while cnum_1_b == -1
            c = s_allnum[i]
            if isdigit(c)
                cnum_1_b = parse(Int64, c)
            end
            i += 1
        end

       # get the final digit
       cnum_2_a = cnum_2_b = -1
        for c in s
            if isdigit(c)
                cnum_2_a = parse(Int64, c)
            end
        end

        for c in s_allnum
            if isdigit(c)
                cnum_2_b = parse(Int64, c)
            end
        end

        # TASK 1
        cali_sum_a += (10*cnum_1_a+cnum_2_a)
        # TASK 2
        cali_sum_b += (10*cnum_1_b+cnum_2_b)
    end
   
  println("The sum of the calibration numbers without conversion is $cali_sum_a")
  println("The sum of the calibration numbers after conversion is $cali_sum_b")
  end
  