-- 为用户词典的内容结尾加上一个星号 *
local function is_in_user_dict(input, env)
    for cand in input:iter() do
        if cand.type == "user_phrase" then
            cand.comment = cand.comment .. '*'
        end
        yield(cand)
    end
end

return is_in_user_dict
