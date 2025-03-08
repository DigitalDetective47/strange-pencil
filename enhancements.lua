SMODS.Enhancement({
    key = "diseased",
    name = "Diseased Card",
    config = { total = 5, remaining = 5, created_during_scoring = false },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.remaining, card.ability.total } }
    end,
    calculate = function(self, card, context)
        if G.GAME.hands_played >= card.ability.hands_played_at_create + (card.ability.created_during_scoring and 1 or 0) and context.before and context.cardarea == G.play then
            local changed = false
            local pos
            for k, v in ipairs(context.scoring_hand) do
                if v == card then
                    pos = k
                    break
                end
            end
            local q = context.scoring_hand[pos - 1]
            if q and not SMODS.has_enhancement(q, "m_pencil_diseased") then
                q:set_ability(G.P_CENTERS["m_pencil_diseased"], nil, true)
                q.ability.created_during_scoring = true
                changed = true
            end
            q = context.scoring_hand[pos + 1]
            if q and not SMODS.has_enhancement(q, "m_pencil_diseased") then
                q:set_ability(G.P_CENTERS["m_pencil_diseased"], nil, true)
                q.ability.created_during_scoring = true
                changed = true
            end
            if changed then
                return { message = localize('k_infected_ex') }
            end
        elseif context.playing_card_end_of_round then
            card.ability.remaining = card.ability.remaining - 1
            if card.ability.remaining <= 0 then
                card:remove()
            end
        end
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
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                blocking = false,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        blocking = false,
                        func = function()
                            for k, v in ipairs(G.deck.cards) do
                                if v == card then
                                    card.ability.pos = k
                                    return true
                                end
                            end
                        end
                    }))
                    return true
                end
            }))
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

if next(SMODS.find_mod("cartomancer")) then
    local cartomancer_stringify_hook = Card.cart_to_string
    function Card:cart_to_string(args)
        return cartomancer_stringify_hook(self, args) ..
            (SMODS.has_enhancement(self, "m_pencil_flagged") and self.ability.pos and self.ability.pos <= #G.deck.cards and tostring(self.ability.pos) or "")
    end
end

local flip_hook = Card.flip
function Card:flip()
    if not (self.area == G.hand and SMODS.has_enhancement(self, "m_pencil_flagged") and self.facing ~= 'back') then
        return flip_hook(self)
    end
end

local emplace_hook = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    return emplace_hook(self, card, location, stay_flipped and not SMODS.has_enhancement(card, "m_pencil_flagged"))
end

if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config["Enhanced Decks"] then
    Cryptid.edeck_sprites.enhancement.m_pencil_diseased = { atlas = "pencil_enhancements", pos = { x = 2, y = 0 } }
    Cryptid.edeck_sprites.enhancement.m_pencil_flagged = { atlas = "pencil_enhancements", pos = { x = 2, y = 1 } }
end
