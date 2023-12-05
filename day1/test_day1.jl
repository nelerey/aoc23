include("trebuchet_calibration.jl")
using Test

text = [
    "1abc2",
    "pqr3stu8vwx",
    "a1b2c3d4e5f",
    "treb7uchet"]


function test_trebuchet_calibration(text)
    cali_sum_a = 0
    cali_sum_b = 0

    for s in text
        # convert spelled-out numbers to digits for TASK 2
        s_allnum = parse_spelled_numbers(s)
        println(s_allnum, s)

        # extract numbers
        num_a = extract_number(s)
        num_b = extract_number(s_allnum)

        # TASK 1
        cali_sum_a += num_a
        # TASK 2
        cali_sum_b += num_b
    end

    return cali_sum_a, cali_sum_b
end

task1, task2 = test_trebuchet_calibration(text)
@test task1 == 142
@test task2 == 281