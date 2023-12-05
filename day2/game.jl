"""
new julia skills:
    functions
    regex including with variable substrings
    enumerate
    testing
    use functions from other scripts
    check how script is being run and execute accordingly
    local and global scopes!
"""
function extract_id(s::String)
    return  parse(Int64, match(r"(?<=Game\s)(\d+)", s).match)
end


function get_max_coloured_cubes(s::String, colour::String)
    @assert colour in ["blue", "green", "red"]
    max_ncubes = 0
    for m in eachmatch(Regex("(\\d+)(?=\\s$colour)"), s)
        ncubes = parse(Int32, m.match)
        if ncubes > max_ncubes
            max_ncubes = ncubes
        end
    end
    return max_ncubes
end


function is_possiblegame(s::String, loaddict::Dict{String, <: Int})
    # true if the maximum number of cubes of all colours is equal to or greater than the loaded number of cubes.
    game_poss = Vector{Union{Bool, Missing}}(missing, length(loaddict))
    for (i, (key, value)) in enumerate(loaddict)
        game_poss[i] = get_max_coloured_cubes(s, key) <= value
    end

    return all(game_poss)
end


function sumpossibleids(lines, loaddict::Dict{String, <: Int})
    ids = Vector{Union{Int64, Missing}}(missing, length(lines))

    for (i, line) in enumerate(lines)

        if is_possiblegame(line, loaddict)
            ids[i] = extract_id(line)
        end
    end
    return sum(skipmissing(ids)) 
end


function sumpow_minncubes(lines)
    pows = Vector{Union{Int64, Missing}}(missing, length(lines))
    for (i, line) in enumerate(lines)
        mincubes_i = [0,0,0]
        for (c,colour) in enumerate(["red", "green", "blue"])
            mincubes_i[c] = get_max_coloured_cubes(line, colour)
        end
        pows[i] = prod(mincubes_i)
    end
    return sum(pows)
end


filepath = joinpath(@__DIR__, "input.txt")

if abspath(PROGRAM_FILE) == @__FILE__   # if __name__ == "main"

    lines = readlines(filepath) 
    loaddict = Dict("red"=>12, "green"=>13, "blue"=>14)
    result1 = sumpossibleids(lines, loaddict)
    println(result1)
    result2 = sumpow_minncubes(lines)
    println(result2)
end