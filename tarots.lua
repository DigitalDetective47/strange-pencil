SMODS.Consumable {
    key = "abundance",
    set = "Tarot",
    pos = { x = 0, y = 0 },
    atlas = "tarots",
    config = { numerator = 1, denominator = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.numerator, card.ability.denominator, self:cash_value(card) } }
    end,
    cash_value = function(self, card)
        return G.playing_cards and math.floor(#G.playing_cards / card.ability.denominator) * card.ability.numerator or 0
    end,
    can_use = StrangeLib.consumable.use_templates.always_usable,
    use = function(self, card, area)
        G.E_MANAGER:add_event(Event { trigger = "after", delay = 0.4, func = function()
            play_sound("timpani")
            card:juice_up(0.3, 0.5)
            ease_dollars(self:cash_value(card), true)
            return true
        end })
        delay(0.6)
    end,
}
