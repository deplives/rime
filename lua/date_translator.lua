-- 日期时间

local formats = {
    date = {
        "%Y-%m-%d",
        "%Y 年 %m 月 %d 日"
    },
    time = {
        "%H:%M:%S"
    },
    datetime = {
        "%Y-%m-%d %H:%M:%S"
    },
    week = {
        "星期%s"
    },
    timestamp = {
        "%d"
    }
}

local function date_translator(input, seg, env)
    if not env.date then
        local config = env.engine.schema.config
        env.name_space = env.name_space:gsub("^*", "")
        env.date = config:get_string(env.name_space .. "/date") or "date"
        env.time = config:get_string(env.name_space .. "/time") or "time"
        env.week = config:get_string(env.name_space .. "/week") or "week"
        env.datetime = config:get_string(env.name_space .. "/datetime") or "datetime"
        env.timestamp = config:get_string(env.name_space .. "/timestamp") or "timestamp"
    end

    local current_time = os.time()

    local yield_cand = function(type, text)
        local cand = Candidate(type, seg.start, seg._end, text, "")
        cand.quality = 100
        yield(cand)
    end

    -- 日期
    if (input == env.date) then
        for _, fmt in ipairs(formats.date) do
            yield_cand("date", os.date(fmt, current_time))
        end
    end
    -- 时间
    if (input == env.time) then
        for _, fmt in ipairs(formats.time) do
          yield_cand("time", os.date(fmt, current_time))
        end
    end
    -- 星期
    if (input == env.week) then
        local week_tab = {"日", "一", "二", "三", "四", "五", "六"}
        for _, fmt in ipairs(formats.week) do
          local text = week_tab[tonumber(os.date("%w", current_time) + 1)]
          yield_cand("week", string.format(fmt, text))
        end
    end
    -- 日期时间
    if (input == env.datetime) then
        for _, fmt in ipairs(formats.datetime) do
          yield_cand("datetime", os.date(fmt, current_time))
        end
    end
    -- 时间戳
    if (input == env.timestamp) then
        for _, fmt in ipairs(formats.timestamp) do
          yield_cand("timestamp", string.format(fmt, current_time))
        end
    end
end

return date_translator
