--[[
-- A -> rock
-- B -> paper
-- C -> scissors

-- X -> rock
-- Y -> paper
-- Z -> scissors

-- actually though
 X -> lose
 Y -> draw
 Z -> win

--[[

total score - sum of scores for each round
single round:
1 for rock
2 for paper
3 for scissors
+ outcome
0 for lost
3 for draw
6 for won
]]




local ROCK = 1
local PAPER = 2
local SCISSORS = 3

local WIN = 6
local TIE = 3
local LOSE = 0

function matchRes(me, you)
    if me == you then
        return 3
    elseif me == ROCK and you == SCISSORS then
        return 6
    elseif me == PAPER and you == ROCK then
        return 6
    elseif me == SCISSORS and you == PAPER then
        return 6
    else
        return 0
    end
end

function respRes(res, you)
    if res == TIE then
        return you
    elseif res == WIN then
        -- 1 offset sadness
        return you % 3 + 1
    else
        return (you + 1) % 3 + 1
    end
end

function readInput(fname)
    local charMap = {
        A = ROCK,
        B = PAPER,
        C = SCISSORS,
        X = ROCK,
        Y = PAPER,
        Z = SCISSORS
    }
    local resMap = {
        X = LOSE,
        Y = TIE,
        Z = WIN
    }
    local seq = {}
    for l in io.lines(fname) do
        local _, _, opponent = l:find("([ABC])")
        local _, _, response = l:find("([XYZ])")

        if opponent == nil or response == nil then
            print("error: nil round")
            break
        end

        table.insert(seq, { opponent = charMap[opponent], response = charMap[response], result = resMap[response] })
    end
    return seq
end

-- start script

local seq = readInput(arg[1])
local score = 0
for _, v in ipairs(seq) do
    score = score + v.response + matchRes(v.response, v.opponent)
end

print("Opponent/Self:", score)

score = 0

for _, v in ipairs(seq) do
    score = score + v.result + respRes(v.result, v.opponent)
end

print("Opponent/Result:", score)
