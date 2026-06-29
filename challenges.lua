SMODS.Challenge {
    key = "permamouth",
    rules = {
        custom = {
            { id = "pencil_most_played_only" },
        },
    },
    vouchers = {
        { id = "v_telescope" },
        { id = "v_hieroglyph" },
    },
    restrictions = {
        banned_other = {
            { id = "bl_psychic", type = "blind" },
        }
    }
}

SMODS.Challenge {
    key = "immutable",
    restrictions = {
        banned_cards = {},
        banned_tags = {
            { id = "tag_pencil_workshop" },
        },
        banned_other = {},
    },
}

SMODS.Challenge {
    key = "old_negative",
    rules = {
        custom = {
            { id = "no_hand_chips" },
            { id = "no_planet_chips" },
        }
    },
    restrictions = {
        banned_cards = {}
    },
    apply = function(self)
        for _, hand in pairs(G.GAME.hands) do
            hand.chips = 0
            hand.s_chips = 0
            hand.l_chips = 0
        end
    end,
}

G.E_MANAGER:add_event(Event { blockable = false, func = function()
    for _, key in ipairs(SMODS.get_attribute_pool("hand_type")) do
        if G.P_BLINDS[key] ~= nil then
            table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other, { id = key, type = "blind" })
        end
    end
    for _, key in ipairs(SMODS.get_attribute_pool("modify_card")) do
        if G.P_CENTERS[key] ~= nil then
            table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = key })
        end
        if G.P_BLINDS[key] ~= nil then
            table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_other, { id = key, type = "blind" })
        end
    end
    for _, key in ipairs(SMODS.merge_lists { SMODS.get_attribute_pool("chips"), SMODS.get_attribute_pool("xchips"), SMODS.get_attribute_pool("fchips") }) do
        if G.P_CENTERS[key] ~= nil then
            table.insert(SMODS.Challenges.c_pencil_old_negative.restrictions.banned_cards, { id = key })
        end
    end
    return true
end })
