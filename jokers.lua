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
    cost = 4,
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

SMODS.Joker({
    key = "lass",
    config = { extra = { xmult = 1, xmult_per_queen = 1 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.xmult_per_queen,
                center.ability.extra.xmult,
            },
        }
    end,
    rarity = 3,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    cost = 7,
    blueprint_compat = true,
    update = function(self, card, dt)
        card.ability.extra.xmult = 0
        for k, v in ipairs(G.playing_cards or {}) do
            if v.base.suit == "Clubs" and v.base.id == 12 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_per_queen
            end
        end
        card.ability.extra.xmult = math.max(card.ability.extra.xmult, 1)
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and not context.before and not context.after and card.ability.extra.xmult > 1 then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
				Xmult_mod = card.ability.extra.xmult,
			}
		end
    end,
})
