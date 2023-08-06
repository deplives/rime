-- 错音错字提示

local corrections = {
    -- 错音
    ["hun dun"] = { text = "馄饨", comment = "(hún tún)" },
    ["zhu jiao"] = { text = "主角", comment = "(zhǔ jué)" },
    ["jiao se"] = { text = "角色", comment = "(jué sè)" },
    ["pi sa"] = { text = "比萨", comment = "(bǐ sà)" },
    ["pu gai"] = { text = "扑街", comment = "(pū jiē)" },
    ["gai liu zi"] = { text = "街溜子", comment = "(jiē liū zǐ)" },
    ["shui fu"] = { text = "说服", comment = "(shuō fú)" },
    ["zuo ji"] = { text = "坐骑", comment = "(zuò qí)" },
    ["yi ji jue chen"] = { text = "一骑绝尘", comment = "(yī qí jué chén)" },
    ["yi ji hong chen fei zi xiao"] = { text = "一骑红尘妃子笑", comment = "(yī qí jué chén fēi zǐ xiào)" },
    ["qian li zou dan ji"] = { text = "千里走单骑", comment = "(qiān lǐ zǒu dān qí)" },
    ["yi ji dang qian"] = { text = "一骑当千", comment = "(yī qí dāng qiān)" },
    ["dao hang"] = { text = "道行", comment = "(dào héng)" },
    ["mo yang"] = { text = "模样", comment = "(mú yàng)" },
    ["you mo you yang"] = { text = "有模有样", comment = "(yǒu mó yǒu yàng)" },
    ["yi mo yi yang"] = { text = "一模一样", comment = "(yī mú yī yàng)" },
    ["zhuang mo zuo yang"] = { text = "装模作样", comment = "(zhuāng mú zuò yàng)" },
    ["ren mo gou yang"] = { text = "人模狗样", comment = "(rén mó gǒu yàng)" },
    ["e fang gong"] = { text = "阿房宫", comment = "(ē páng gōng)" },
    ["gei yu"] = { text = "给予", comment = "(jǐ yǔ)" },
    ["bin lang"] = { text = "槟榔", comment = "(bīng láng)" },
    ["zhang bai zhi"] = { text = "张柏芝", comment = "(zhāng bó zhī)" },
    ["teng man"] = { text = "藤蔓", comment = "(téng wàn)" },
    ["nong tang"] = { text = "弄堂", comment = "(lòng táng)" },
    ["xin kuan ti pang"] = { text = "心宽体胖", comment = "(xīn kuān tǐ pán)" },
    ["mai yuan"] = { text = "埋怨", comment = "(mán yuàn)" },
    ["xu yu wei she"] = { text = "虚与委蛇", comment = "(xū yǔ wēi yí)" },
    ["mu na"] = { text = "木讷", comment = "(mù nè)" },
    -- 错字
    ["an nai"] = { text = "按耐", comment = "(按捺(nà))" },
    ["an nai bu zhu"] = { text = "按耐不住", comment = "(按捺(nà)不住)" },
}

local function corrector(input)
    for cand in input:iter() do
        local c = corrections[cand.comment]
        if c and cand.text == c.text then
            cand:get_genuine().comment = c.comment
        else
            cand:get_genuine().comment = ""
        end
        yield(cand)
    end
end

return corrector
