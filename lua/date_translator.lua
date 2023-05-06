-- 日期时间
local function date_translator(input, seg, env)
    if not env.date then
        local config = env.engine.schema.config
        env.name_space = env.name_space:gsub("^*", "")
        env.date = config:get_string(env.name_space .. "/date") or "rq"
        env.time = config:get_string(env.name_space .. "/time") or "sj"
        env.week = config:get_string(env.name_space .. "/week") or "xq"
        env.datetime = config:get_string(env.name_space .. "/datetime") or "dt"
        env.timestamp = config:get_string(env.name_space .. "/timestamp") or "ts"
    end

    -- 日期
    if (input == env.date) then
        local cand = Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "")
        cand.quality = 100
        yield(cand)
        local cand = Candidate("date", seg.start, seg._end, os.date("%Y 年 %m 月 %d 日"), "")
        cand.quality = 100
        yield(cand)
    end
    -- 时间
    if (input == env.time) then
        local cand = Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "")
        cand.quality = 100
        yield(cand)
        local cand = Candidate("time", seg.start, seg._end, os.date("%H:%M"), "")
        cand.quality = 100
        yield(cand)
    end
    -- 星期
    if (input == env.week) then
        local weakTab = {
            '日',
            '一',
            '二',
            '三',
            '四',
            '五',
            '六'
        }
        local cand = Candidate("week", seg.start, seg._end, "星期" .. weakTab[tonumber(os.date("%w") + 1)], "")
        cand.quality = 100
        yield(cand)
    end
    -- ISO 8601/RFC 3339 的时间格式
    if (input == env.datetime) then
        local cand = Candidate("datetime", seg.start, seg._end, os.date("%Y-%m-%dT%H:%M:%S+08:00"), "")
        cand.quality = 100
        yield(cand)
        local cand = Candidate("time", seg.start, seg._end, os.date("%Y%m%d%H%M%S"), "")
        cand.quality = 100
        yield(cand)
    end
    -- 时间戳
    if (input == env.timestamp) then
        local cand = Candidate("datetime", seg.start, seg._end, os.time(), "")
        cand.quality = 100
        yield(cand)
    end
end

return date_translator
