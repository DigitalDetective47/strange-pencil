--- STEAMODDED HEADER
--- MOD_NAME: Strange Pencil
--- MOD_ID: StrangePencil
--- MOD_AUTHOR: [DigitalDetective47]
--- MOD_DESCRIPTION: A collection of random stuff that I've created and drawn in Paint.
--- PRIORITY: 0
--- VERSION: 0.0.1
--- PREFIX: pencil

SMODS.Challenge({
    key = "debug",
    rules = {
        modifiers = {
            { id = "dollars", value = 1e200 },
        }
    },
    jokers = {
        { id = "j_pencil_swimmers" },
        { id = "j_cry_gemino" }
    },
    consumeables = {
        { id = "c_cry_pointer" },
        { id = "c_cry_pointer" },
    },
    deck = {
        cards = { { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, },
        type = 'Challenge Deck'
    },
})
SMODS.Challenge({
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
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
            { id = "j_obelisk" },
            { id = "j_cry_fspinner" },
        },
        banned_other = {
            { id = 'bl_ox',            type = 'blind' },
            { id = 'bl_eye',           type = 'blind' },
            { id = 'bl_mouth',         type = 'blind' },
            { id = "bl_cry_oldhouse",  type = 'blind' },
            { id = "bl_cry_oldpillar", type = 'blind' },
            { id = "bl_cry_oldflint",  type = 'blind' },
            { id = "bl_cry_oldmark",   type = 'blind' },
        }
    }
})
FirstHand = nil

SMODS.Atlas({
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
})

SMODS.Joker({
    key = "swimmers",
    config = { extra = { mult = 22 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult,
            },
        }
    end,
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and not context.before and not context.after and context.scoring_hand then
            local enhancement = nil;
            for i = 1, #context.scoring_hand do
                if enhancement then
                    if context.scoring_hand[i].ability.name ~= enhancement then
                        return {}
                    end
                elseif context.scoring_hand[i].ability.name ~= "Default Base" then
                    enhancement = context.scoring_hand[i].ability.name
                else
                    return {}
                end
            end
            return {
                message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
                mult_mod = card.ability.extra.mult,
            }
        end
    end,
})
