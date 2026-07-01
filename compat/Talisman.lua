SMODS.Joker:take_ownership("pencil_square", {
    calculate = function(self, card, context)
        if context.joker_main then
            return { echips = card.ability.exponent }
        end
    end,
}, true)
