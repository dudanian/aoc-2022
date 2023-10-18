function readLine(l)
    local arr = {}

    local s = 1
    local e = 1

    for i = 1, 4 do
        s, e = l:find("%d+", s)

        local a = l:sub(s, e)

        table.insert(arr, tonumber(a))

        s = e + 1
    end
    return table.unpack(arr)
end

function readInput(fname)
    local count = 0

    local count2 = 0
    for l in io.lines(fname) do
        local s1, e1, s2, e2 = readLine(l)

        if (s1 >= s2 and e1 <= e2) or (s2 >= s1 and e2 <= e1) then
            count = count + 1
        end

        if (s1 >= s2 and s1 <= e2) or (s2 >= s1 and s2 <= e1) then
            count2 = count2 + 1
        end
    end

    print(count, count2)
end

-- start script

readInput(arg[1])
