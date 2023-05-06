-- v 模式，单个字符优先
local function v_filter(input, env)
    local code = env.engine.context.input
    env.v_spec_arr = env.v_spec_arr or Set({
        "0️⃣",
        "1️⃣",
        "2️⃣",
        "3️⃣",
        "4️⃣",
        "5️⃣",
        "6️⃣",
        "7️⃣",
        "8️⃣",
        "9️⃣"
    })
    -- 仅当当前输入以 v 开头，并且编码长度为 2，才进行处理
    if (string.len(code) == 2 and string.find(code, "^v")) then
        local l = {}
        for cand in input:iter() do
            if (env.v_spec_arr[cand.text]) then
                yield(cand)
            elseif (utf8.len(cand.text) == 1) then
                yield(cand)
            else
                table.insert(l, cand)
            end
        end
        for _, cand in ipairs(l) do
            yield(cand)
        end
    else
        for cand in input:iter() do
            yield(cand)
        end
    end
end

return v_filter
