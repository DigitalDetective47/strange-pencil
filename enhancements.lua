SMODS.Atlas({
    key = "enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95,
})

SMODS.Enhancement({
    key = "diseased",
    name = "Diseased Card",
    config = { total = 5, remaining = 5, new = false },
    loc_vars = function(self, info_queue, card)
        return { vars = { card and card.ability.remaining or self.config.remaining, card and card.ability.total or self.config.total } }
    end,
    atlas = "enhancements",
    pos = { x = 0, y = 0 }
})

SMODS.Consumable({
    key = "plague",
    set = "Tarot",
    atlas = "enhancements",
    pos = { x = 1, y = 0 },
    config = { mod_conv = "m_pencil_diseased", max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_pencil_diseased)
        return { vars = { card.ability.max_highlighted } }
    end,
})
table.insert(SMODS.Challenges.c_fragile_1.restrictions.banned_cards, 8, { id = "c_pencil_plague" })
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Challenges"] then
    table.insert(SMODS.Challenges.c_cry_ballin.restrictions.banned_cards, 10, { id = "c_pencil_plague" })
end
