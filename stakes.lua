SMODS.Stake({
    key = "charred",
    applied_stakes = { "gold" },
    prefix_config = { applied_stakes = { mod = false } },
    atlas = "stakes",
    pos = { x = 1, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 1, y = 0 },
    colour = { 0, 1, 0, 1 },
    above_stake = "gold",
    modifiers = function()
        G.GAME.modifiers.covid_19 = true
    end
})

local hook = eval_card
function eval_card(card, context)
    local ret, ret2 = hook(card, context)
    if context.before and context.cardarea == G.play and G.GAME.modifiers.covid_19 and pseudorandom("disease_exposure") > 0.9 then
        card:set_ability(SMODS.Centers["m_pencil_diseased"], nil, true)
    end
    return ret, ret2
end

SMODS.Stake({
    key = "neon",
    applied_stakes = { "charred" },
    atlas = "stakes",
    pos = { x = 0, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 0, y = 0 },
    colour = HEX("A52F00"),
    above_stake = "stake_pencil_charred",
    modifiers = function()
        G.GAME.modifiers.enable_pencil_paralyzed = true
    end
})

local hook2 = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local ret = hook2(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.GAME.modifiers.enable_pencil_paralyzed and pseudorandom((area == G.pack_cards and "pack" or "") .. "_pencil_paralyzed" .. G.GAME.round_resets.ante) > 0.7
        and _type == "Joker" and (area == G.shop_jokers or area == G.pack_cards) then
        SMODS.Stickers.pencil_paralyzed:apply(ret, true)
    end
    return ret
end
