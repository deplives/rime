-- 英文单词后面自动加一个空格

local function add_space_to_english_word(input)
    input = input:gsub("(%a+'?%a*)", "%1 ")
    return input
end

-- 在候选项上屏时触发的函数
function en_spacer(input, env)
    for cand in input:iter() do
        if cand.text:match("^[%a']+[%a']*$") then
            cand = cand:to_shadow_candidate(cand.type, add_space_to_english_word(cand.text), cand.comment)
        end
        yield(cand)
    end
end

return en_spacer
