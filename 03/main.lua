-- each unique letter is an item type
-- each line is a bag
-- first half is first compartment, second is second

-- item priority is the int value of the item type
-- almost, lowercase has lower priority

-- okay, so we want the sum of the item types that are in both rucksacks

local lowerA = ("a"):byte()
local lowerZ = ("z"):byte()
local upperA = ("A"):byte()
local upperZ = ("Z"):byte()

function toPriority(c)
    local b = c:byte()
    if b >= lowerA and b <= lowerZ then
        return b - lowerA + 1
    else
        return b - upperA + 27
    end
end

-- if I call this with a substring I can reuse it
function fillBucket(line, bucket)
    bucket = bucket or {}
    for i = 1, #line do
        local c = line:sub(i, i)
        bucket[c] = (bucket[c] or 0) + 1
    end
    return bucket
end

function intersectBuckets(b1, b2)
    -- pretty weird way to get whether a table is empty or not
    if next(b1) == nil then
        return b2
    end
    if next(b2) == nil then
        return b1
    end
    local b3 = {}
    for k, v in pairs(b1) do
        if b2[k] ~= nil then
            b3[k] = v
        end
    end
    return b3
end

-- this finds the "missing" letter
function findFirstSame(line, bucket)
    for i = 1, #line do
        local c = line:sub(i, i)
        if bucket[c] ~= nil then
            return c
        end
    end
end

function findFirstMissing(line, bucket)
    for i = 1, #line do
        local c = line:sub(i, i)
        if bucket[c] == nil then
            return c
        end
    end
end

-- old code, not deleting yet
function _parseLine(line, bucket)
    local itm = {}

    local i = 1

    while i <= #line / 2 do
        local c = line:sub(i, i)
        itm[c] = (itm[c] or 0) + 1
        bucket[c] = (bucket[c] or 0) + 1
        i = i + 1
    end

    while i <= #line do
        local c = line:sub(i, i)
        bucket[c] = (bucket[c] or 0) + 1
        if itm[c] ~= nil then
            return c
        end
        i = i + 1
    end
end

function printBucket(b)
    for k, v in pairs(b) do
        print(k, v)
    end
end

function readInput(fname)
    local sum = 0

    local b = {}
    local sum2 = 0
    local row = 0 -- idk if there is a better way to get the index?
    for l in io.lines(fname) do
        -- part 1
        local p1b = fillBucket(l:sub(1, #l / 2))
        local p1 = findFirstSame(l:sub(#l / 2 + 1, -1), p1b)

        local p = toPriority(p1)
        sum = sum + p

        -- part 2

        local b2 = fillBucket(l)
        b = intersectBuckets(b, b2)
        row = row + 1

        if row == 3 then
            local v = next(b)
            b = {}
            row = 0
            sum2 = sum2 + toPriority(v)
        end
    end

    print(sum)
    print(sum2)
end

-- start script

readInput(arg[1])
