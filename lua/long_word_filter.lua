-- 长词优先（提升「西安」「提案」「图案」「饥饿」等词汇的优先级）
local function long_word_filter(input, env)
    -- 提升 count 个词语，插入到第 idx 个位置，默认 2、4
    if not env.idx then
        local config = env.engine.schema.config
        env.name_space = env.name_space:gsub("^*", "")
        env.idx = config:get_int(env.name_space .. "/idx") or 4
        env.count = config:get_int(env.name_space .. "/count") or 2
    end

    local l = {}
    local firstWordLength = 0
    local done = 0
    local i = 1
    for cand in input:iter() do
        local leng = utf8.len(cand.text)
        if (firstWordLength < 1 or i < env.idx) then
            i = i + 1
            firstWordLength = leng
            yield(cand)
        elseif ((leng > firstWordLength) and (done < env.count)) and (string.find(cand.text, "[%w%p%s]+") == nil) then
            yield(cand)
            done = done + 1
        else
            table.insert(l, cand)
        end
        if (done == env.count) or (#l > 50) then
            break
        end
    end
    for _, cand in ipairs(l) do
        yield(cand)
    end
    for cand in input:iter() do
        yield(cand)
    end
end

return long_word_filter
