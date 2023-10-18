local function parseFile(f)
    -- this is an array
    local elves = {}
    -- we should be able to 1-index, convenient?
    local elf = 1
    -- sum per-elf
    local sum = 0

    for line in io.lines(f) do
        if line == "" then
            elves[elf] = sum
            -- reset
            elf = elf + 1
            sum = 0
        else
            local calories = tonumber(line)
            sum = sum + calories
        end
    end
    -- last one
    elves[elf] = sum

    return elves
end

local function toPairs(arr)
    local res = {}

    for k, v in pairs(arr) do
        res[k] = { k, v }
    end

    return res
end

-- start script

local elves = parseFile(arg[1])
local p = toPairs(elves)
table.sort(p, function(a, b)
    return a[2] > b[2]
end)

print("Ranking:")
local sum = 0
for v = 1, 3 do
    local val = p[v][2]
    print(v, val)
    sum = sum + val
end
print("")
print("Sum of top 3: ")
print(sum)
