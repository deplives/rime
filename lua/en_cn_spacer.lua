-- 中英混输词条自动空格
local function add_spaces(s)
    -- 在中文字符后和英文字符前插入空格
    s = s:gsub("([\228-\233][\128-\191]-)([%w%p])", "%1 %2")
    -- 在英文字符后和中文字符前插入空格
    s = s:gsub("([%w%p])([\228-\233][\128-\191]-)", "%1 %2")
    return s
end

-- 是否同时包含中文和英文数字
local function is_mixed_en_cn_num(s)
    return s:find("([\228-\233][\128-\191]-)") and s:find("[%a%d]")
end

local function en_cn_spacer(input, env)
    for cand in input:iter() do
        if is_mixed_en_cn_num(cand.text) then
            cand = cand:to_shadow_candidate(cand.type, add_spaces(cand.text), cand.comment)
        end
        yield(cand)
    end
end

return en_cn_spacer
