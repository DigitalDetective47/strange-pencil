SMODS.Stake {
    key = "bronze",
    applied_stakes = { "gold" },
    prefix_config = { applied_stakes = { mod = false } },
    atlas = "stakes",
    pos = { x = 3, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 3, y = 0 },
    colour = G.C.ORANGE,
    shiny = true,
    above_stake = "gold",
    modifiers = function()
        G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
    end
}

SMODS.Stake {
    key = "rainbow",
    applied_stakes = { "bronze" },
    atlas = "stakes",
    pos = { x = 4, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 4, y = 0 },
    colour = { 0, 1, 1, 1 },
    above_stake = "stake_pencil_bronze",
    modifiers = function()
        G.GAME.modifiers.scaling = 4
    end
}

SMODS.Stake {
    key = "charred",
    applied_stakes = { "rainbow" },
    atlas = "stakes",
    pos = { x = 1, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 1, y = 0 },
    colour = HEX("A52F00"),
    above_stake = "stake_pencil_rainbow",
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
    colour = { 0, 1, 0, 1 },
    above_stake = "stake_pencil_charred",
    modifiers = function()
        G.GAME.modifiers.enable_pencil_paralyzed = true
    end
}

SMODS.Stake {
    key = "blue",
    applied_stakes = { "neon" },
    atlas = "stakes",
    pos = { x = 5, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 5, y = 0 },
    colour = { 0, 0, 0, 1 },
    above_stake = "stake_pencil_neon",
    modifiers = function()
        G.GAME.modifiers.no_blind_reward.Big = true
    end
}

SMODS.Stake {
    key = "transparent",
    applied_stakes = { "blue" },
    atlas = "stakes",
    pos = { x = 6, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 6, y = 0 },
    colour = { 1, 1, 1, 0.5 },
    above_stake = "stake_pencil_blue",
    modifiers = function()
        G.GAME.modifiers.scaling = 5
    end
}

SMODS.Stake {
    key = "grey",
    applied_stakes = { "transparent" },
    atlas = "stakes",
    pos = { x = 2, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 2, y = 0 },
    colour = { 0.5, 0.5, 0.5, 1 },
    above_stake = "stake_pencil_transparent",
    modifiers = function()
        G.GAME.modifiers.enable_pencil_suitless = true
        G.E_MANAGER:add_event(Event { blockable = false, func = function()
            for _, card in ipairs(G.playing_cards) do
                if SMODS.Stickers.pencil_suitless:should_apply(card, card.config.center, G.deck) then
                    SMODS.Stickers.pencil_suitless:apply(card, true)
                end
            end
            return true
        end })
    end
}

SMODS.Stake {
    key = "negative",
    applied_stakes = { "grey" },
    atlas = "stakes",
    pos = { x = 7, y = 0 },
    sticker_atlas = "stake_stickers",
    sticker_pos = { x = 7, y = 0 },
    colour = { 0.5, 0, 0.5, 1 },
    shiny = true,
    above_stake = "stake_pencil_grey",
    modifiers = function()
        for _, hand in pairs(G.GAME.hands) do
            hand.chips = 0
            hand.s_chips = 0
        end
    end
}
