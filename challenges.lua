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
            { id = "bl_ox",      type = "blind" },
            { id = "bl_psychic", type = "blind" },
            { id = "bl_eye",     type = "blind" },
            { id = "bl_mouth",   type = "blind" },
        }
    }
}

SMODS.Challenge {
    key = "immutable",
    restrictions = {
        banned_cards = {
            { id = "c_magician" },
            { id = "c_empress" },
            { id = "c_heirophant" },
            { id = "c_lovers" },
            { id = "c_chariot" },
            { id = "c_justice" },
            { id = "c_wheel_of_fortune" },
            { id = "c_strength" },
            { id = "c_death" },
            { id = "c_devil" },
            { id = "c_tower" },
            { id = "c_star" },
            { id = "c_moon" },
            { id = "c_sun" },
            { id = "c_world" },
            { id = "c_pencil_plague" },
            { id = "c_pencil_parade" },
            { id = "c_pencil_kfc" },
            { id = "c_talisman" },
            { id = "c_aura" },
            { id = "c_sigil" },
            { id = "c_ouija" },
            { id = "c_ectoplasm" },
            { id = "c_deja_vu" },
            { id = "c_hex" },
            { id = "c_trance" },
            { id = "c_medium" },
            { id = "c_pencil_chisel" },
            { id = "c_pencil_mixnmatch" },
        },
        banned_tags = {
            { id = "tag_pencil_workshop" },
        },
        banned_other = {
            { id = "bl_pencil_lock", type = "blind" },
        },
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
    for _, key in ipairs(SMODS.get_attribute_pool("modify_card")) do
        table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = key })
    end
    for _, key in ipairs(SMODS.merge_lists { SMODS.get_attribute_pool("chips"), SMODS.get_attribute_pool("xchips") }) do
        table.insert(SMODS.Challenges.c_pencil_old_negative.restrictions.banned_cards, { id = key })
    end
    return true
end })
