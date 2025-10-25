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

---Return random numbers from a gaussian distribution
---@param mean number
---@param variance number
---@return number
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
                for _, card in ipairs(G.playing_cards) do
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
                    local succ, msg = SMODS.change_base(card, nil, rank_suffix)
                    if not succ then
                        sendErrorMessage(msg)
                    end
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

local set_ability_hook = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    set_ability_hook(self, center, initial, delay_sprites)
    if self.ability.set == "Booster" and G.GAME.modifiers.booster_choices then
        self.ability.choose = self.ability.choose + G.GAME.modifiers.booster_choices
    end
end

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

local d_six_apply_hook = G.P_TAGS.tag_d_six.apply or function(self, tag, context)
    if context.type == "shop_start" and not G.GAME.shop_d6ed then
        G.GAME.shop_d6ed = true
        tag:yep("+", G.C.GREEN, function()
            G.GAME.round_resets.temp_reroll_cost = 0
            calculate_reroll_cost(true)
            return true
        end)
        tag.triggered = true
        return true
    end
end
local function d_six_apply(self, tag, context)
    if G.GAME.selected_back.name == "b_pencil_slow_roll" then
        if context.type == "shop_start" and not G.GAME.shop_d6ed then
            G.GAME.shop_d6ed = true
            tag:yep("+", G.C.GREEN, function()
                G.GAME.current_round.reroll_cost_increase = 0
                calculate_reroll_cost(true)
                return true
            end)
            tag.triggered = true
            return true
        end
    else
        return d_six_apply_hook(self, tag, context)
    end
end
SMODS.Tag:take_ownership("d_six", { apply = d_six_apply }, true)
local function default_reroll_voucher_apply(self, card)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra
            G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - card.ability.extra)
            return true
        end
    }))
end
local function slow_roll_reroll_voucher_apply(self, card)
    G.E_MANAGER:add_event(Event({
        func = function()
            card.ability.b_pencil_slow_roll_savings = math.min(G.GAME.current_round.reroll_cost_increase,
                card.ability.extra)
            G.GAME.current_round.reroll_cost_increase = math.max(
                G.GAME.current_round.reroll_cost_increase - card.ability.extra, 0)
            calculate_reroll_cost(true)
            return true
        end
    }))
end
local reroll_surplus_redeem_hook = G.P_CENTERS.v_reroll_surplus.redeem or default_reroll_voucher_apply
local function reroll_surplus_redeem(self, card)
    if G.GAME.selected_back.name == "b_pencil_slow_roll" then
        slow_roll_reroll_voucher_apply(self, card)
    else
        reroll_surplus_redeem_hook(self, card)
    end
end
local reroll_glut_redeem_hook = G.P_CENTERS.v_reroll_glut.redeem or default_reroll_voucher_apply
local function reroll_glut_redeem(self, card)
    if G.GAME.selected_back.name == "b_pencil_slow_roll" then
        slow_roll_reroll_voucher_apply(self, card)
    else
        reroll_glut_redeem_hook(self, card)
    end
end
SMODS.Voucher:take_ownership("reroll_surplus", { redeem = reroll_surplus_redeem }, true)
SMODS.Voucher:take_ownership("reroll_glut", { redeem = reroll_glut_redeem }, true)
