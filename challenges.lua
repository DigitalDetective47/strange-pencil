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

local permamouth = {
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
        },
        banned_other = {
            { id = 'bl_ox',    type = 'blind' },
            { id = 'bl_eye',   type = 'blind' },
            { id = 'bl_mouth', type = 'blind' },
        }
    }
}
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Blinds"] then
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldhouse", type = 'blind' })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldpillar", type = 'blind' })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldflint", type = 'blind' })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldmark", type = 'blind' })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Misc. Jokers"] then
    table.insert(permamouth.restrictions.banned_cards, { id = "j_cry_fspinner" })
end
SMODS.Challenge(permamouth)
FirstHand = nil
