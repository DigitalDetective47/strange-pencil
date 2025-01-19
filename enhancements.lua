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
        return { vars = { card.ability.remaining, card.ability.total } }
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

SMODS.Enhancement({
    key = "flagged",
    name = "Flagged Card",
    config = { pos = nil },
    loc_vars = function(self, info_queue, card)
        if card.fake_card then
            return { vars = { "Shows its position in the deck", "" } }
        end
        if G.your_collection then
            for k, v in ipairs(G.your_collection) do
                if card.area == v then
                    return { vars = { "Shows its position in the deck", "" } }
                end
            end
        end
        if card.ability.pos and card.ability.pos <= #G.deck.cards then
            return { vars = { "Drawn in ", #G.deck.cards - card.ability.pos + 1 } }
        else
            return { vars = { "Already drawn", "" } }
        end
    end,
    atlas = "enhancements",
    pos = { x = 0, y = 1 }
})
SMODS.Consumable({
    key = "parade",
    set = "Tarot",
    atlas = "enhancements",
    pos = { x = 1, y = 1 },
    config = { mod_conv = "m_pencil_flagged", max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_pencil_flagged)
        return { vars = { card.ability.max_highlighted } }
    end,
})

if (SMODS.Mods["cartomancer"] or {}).can_load then
    local hook = Card.cart_to_string
    function Card:cart_to_string(args)
        return hook(self, args) .. (SMODS.has_enhancement(self, "m_pencil_flagged") and self.ability.pos and self.ability.pos <= #G.deck.cards and tostring(self.ability.pos) or "")
    end
end

table.insert(SMODS.Challenges.c_fragile_1.restrictions.banned_cards, 8, { id = "c_pencil_plague" })
table.insert(SMODS.Challenges.c_fragile_1.restrictions.banned_cards, 9, { id = "c_pencil_parade" })
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Challenges"] then
    table.insert(SMODS.Challenges.c_cry_ballin.restrictions.banned_cards, 10, { id = "c_pencil_plague" })
    table.insert(SMODS.Challenges.c_cry_ballin.restrictions.banned_cards, 11, { id = "c_pencil_parade" })
end

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Enhanced Decks"] then
    SMODS.Back({
        key = "diseased",
        config = { cry_force_enhancement = "m_pencil_diseased" },
        -- loc_vars = function(self, info_queue, card)
        --     table.insert(info_queue, SMODS.Centers.m_pencil_diseased)
        -- end,
        pos = { x = 2, y = 0 },
        atlas = "enhancements",
    })
    SMODS.Back({
        key = "flagged",
        config = { cry_force_enhancement = "m_pencil_flagged" },
        -- loc_vars = function(self, info_queue, card)
        --     table.insert(info_queue, SMODS.Centers.m_pencil_flagged)
        -- end,
        pos = { x = 2, y = 1 },
        atlas = "enhancements",
    })
end
