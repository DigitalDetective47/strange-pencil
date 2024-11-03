SMODS.Atlas({
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
})

SMODS.Joker({
    key = "swimmers",
    config = { extra = { mult = 11 } },
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
        if context.cardarea == G.play and context.individual then
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
                mult = card.ability.extra.mult,
                card = card,
            }
        end
    end,
})
