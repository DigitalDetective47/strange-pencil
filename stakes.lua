SMODS.Stake {
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
}

local eval_card_hook = eval_card
function eval_card(card, context)
    local ret, ret2 = eval_card_hook(card, context)
    if context.before and context.cardarea == G.play and G.GAME.modifiers.covid_19 and SMODS.pseudorandom_probability(card, "disease_exposure", 1, 10) then
        card:set_ability(SMODS.Centers.m_pencil_diseased, nil, true)
    end
    return ret, ret2
end

SMODS.Stake {
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
}
