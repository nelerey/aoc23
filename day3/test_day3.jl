include("machineparts.jl")

example=[
    "467..114..",
    "...*......",
    "..35..633.",
    "......#...",
    "617*......",
    ".....+.58.",
    "..592.....",
    "......755.",
    "...\$.*....",   # escapechar inserted
    ".664.598.."]
example = paddots(example)

result1, result2 = part12(example)
println(result1)
@test result1 == 4361
println(result2)
@test result2 == 467835