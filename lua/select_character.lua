-- 以词定字
local function utf8_sub(s, i, j)
    i = i or 1
    j = j or -1

    if i < 1 or j < 1 then
        local n = utf8.len(s)
        if not n then
            return nil
        end
        if i < 0 then
            i = n + 1 + i
        end
        if j < 0 then
            j = n + 1 + j
        end
        if i < 0 then
            i = 1
        elseif i > n then
            i = n
        end
        if j < 0 then
            j = 1
        elseif j > n then
            j = n
        end
    end

    if j < i then
        return ""
    end

    i = utf8.offset(s, i)
    j = utf8.offset(s, j + 1)

    if i and j then
        return s:sub(i, j - 1)
    elseif i then
        return s:sub(i)
    else
        return ""
    end
end


local function select_character(key, env)
    local engine = env.engine
    local context = engine.context
    local commit_text = context:get_commit_text()
    local config = engine.schema.config

    local first_key = config:get_string('key_binder/select_first_character')
    local last_key = config:get_string('key_binder/select_last_character')

    if context:has_menu() then
        if (key:repr() == first_key) then
            if (context:get_selected_candidate().text) then
                engine:commit_text(utf8_sub(context:get_selected_candidate().text, 1, 1))
                context:clear()
            end
            return 1
        elseif (key:repr() == last_key) then
            if (context:get_selected_candidate().text) then
                engine:commit_text(utf8_sub(context:get_selected_candidate().text, -1, -1))
                context:clear()
            end
            return 1
        end
    end

    return 2
end

return select_character
