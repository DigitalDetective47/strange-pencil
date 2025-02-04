SMODS.Back({
    key = "royal",
    config = { hand_size = -4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.hand_size } }
    end,
    pos = { x = 0, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if not card:is_face() then
                        card:remove()
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end
})

function Gaussian(mean, variance)
    return math.sqrt(-2 * variance * math.log(pseudorandom('normal_deck'))) *
        math.cos(2 * math.pi * pseudorandom('normal_deck')) + mean
end

SMODS.Back({
    key = "normal",
    config = { mean = 8, variance = 9 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.mean, math.sqrt(self.config.variance) } }
    end,
    pos = { x = 1, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    local rank_suffix
                    repeat
                        rank_suffix = math.floor(Gaussian(self.config.mean, self.config.variance) + 0.5)
                    until rank_suffix >= 2 and rank_suffix <= 14
                    if rank_suffix <= 10 then
                        rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 11 then
                        rank_suffix = 'Jack'
                    elseif rank_suffix == 12 then
                        rank_suffix = 'Queen'
                    elseif rank_suffix == 13 then
                        rank_suffix = 'King'
                    elseif rank_suffix == 14 then
                        rank_suffix = 'Ace'
                    end
                    SMODS.change_base(v, nil, rank_suffix)
                end
                return true
            end
        }))
    end
})

SMODS.Back({
    key = "booster",
    config = { booster_choices = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.booster_choices } }
    end,
    pos = { x = 2, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.GAME.modifiers.booster_choices = (G.GAME.modifiers.booster_choices or 0) + self.config.booster_choices
    end
})

SMODS.Back({
    key = "slow_roll",
    config = { reroll_discount = get_starting_params().reroll_cost, decrement = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { get_starting_params().reroll_cost - self.config.reroll_discount, self.config.decrement } }
    end,
    pos = { x = 3, y = 0 },
    atlas = "decks",
    calculate = function(self, back, context)
        if context.ending_shop then
            G.GAME.b_pencil_slow_roll_reroll_cost = G.GAME.current_round.reroll_cost_increase
        elseif context.end_of_round and G.GAME.b_pencil_slow_roll_reroll_cost then
            G.GAME.current_round.reroll_cost_increase = math.max(
                G.GAME.b_pencil_slow_roll_reroll_cost - self.config.decrement, 0)
            calculate_reroll_cost(true)
        end
    end
})

SMODS.Tag:take_ownership("d_six", {
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not G.GAME.shop_d6ed then
            G.GAME.shop_d6ed = true
            tag:yep('+', G.C.GREEN, function()
                if G.GAME.selected_back.name == "b_pencil_slow_roll" then
                    G.GAME.current_round.reroll_cost_increase = 0
                else
                    G.GAME.round_resets.temp_reroll_cost = 0
                end
                calculate_reroll_cost(true)
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}, true)
