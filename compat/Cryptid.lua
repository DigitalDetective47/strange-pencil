local clubs_create_card_hook = SMODS.Centers.p_pencil_clubs.create_card
local function clubs_create_card(self, card, i)
    if G.GAME.modifiers.cry_force_enhancement and (G.GAME.modifiers.cry_force_enhancement == "m_stone" or G.P_CENTERS[G.GAME.modifiers.cry_force_enhancement].no_suit) then
        if SMODS.pseudorandom_probability(card, 'pencil_clubs_pack', 3, 1000, nil, true) then
            return { set = "clubs_legendary", area = G.pack_cards, skip_materialize = true }
        else
            return { set = "clubs_pack", area = G.pack_cards, skip_materialize = true }
        end
    else
        return clubs_create_card_hook(self, card, i)
    end
end
SMODS.Booster:take_ownership("pencil_clubs", { create_card = clubs_create_card }, true)

Cryptid.edeck_sprites.enhancement.m_pencil_diseased = { atlas = "pencil_enhancements", pos = { x = 2, y = 0 } }
Cryptid.edeck_sprites.enhancement.m_pencil_flagged = { atlas = "pencil_enhancements", pos = { x = 2, y = 1 } }
Cryptid.edeck_sprites.enhancement.m_pencil_sticky = { atlas = "pencil_enhancements", pos = { x = 2, y = 2 } }
Cryptid.edeck_sprites.sticker.pencil_paralyzed = { atlas = "pencil_stickers", pos = { x = 2, y = 0 } }
Cryptid.edeck_sprites.sticker.pencil_suitless = { atlas = "pencil_stickers", pos = { x = 2, y = 1 } }

---@type fun(self: SMODS.Joker, card: Card, initial: boolean?, delay_sprites: boolean?)
local set_stonehenge = SMODS.Centers.j_pencil_stonehenge.set_ability
SMODS.Joker:take_ownership("pencil_stonehenge", { apply_glitched = set_stonehenge, apply_oversat = set_stonehenge }, true)

local function default_reroll_voucher_unapply(self, card)
    G.E_MANAGER:add_event(Event { func = function()
        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra
        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + card.ability.extra)
        return true
    end })
end
local function slow_roll_reroll_voucher_unapply(self, card)
    G.E_MANAGER:add_event(Event { func = function()
        G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase +
            card.ability.b_pencil_slow_roll_savings -- Only roll back the actual amount saved
        calculate_reroll_cost(true)
        return true
    end })
end
local reroll_surplus_unredeem_hook = G.P_CENTERS.v_reroll_surplus.unredeem or default_reroll_voucher_unapply
local function reroll_surplus_unredeem(self, card)
    if G.GAME.selected_back.name == "b_pencil_slow_roll" then
        slow_roll_reroll_voucher_unapply(self, card)
    else
        reroll_surplus_unredeem_hook(self, card)
    end
end
local reroll_glut_unredeem_hook = G.P_CENTERS.v_reroll_glut.unredeem or default_reroll_voucher_unapply
local function reroll_glut_unredeem(self, card)
    if G.GAME.selected_back.name == "b_pencil_slow_roll" then
        slow_roll_reroll_voucher_unapply(self, card)
    else
        reroll_glut_unredeem_hook(self, card)
    end
end
SMODS.Voucher:take_ownership("reroll_surplus", { unredeem = reroll_surplus_unredeem }, true)
SMODS.Voucher:take_ownership("reroll_glut", { unredeem = reroll_glut_unredeem }, true)

SMODS.Sticker:take_ownership("pencil_paralyzed", { pos = { x = 1, y = 0 } }, true) --don't overlap with Banana

local blind_amount_hook = get_blind_amount
function get_blind_amount(ante)
    return (blind_amount_hook(ante) * G.GAME.starting_params.ante_scaling) ^
        (G.GAME.starting_params.ante_scaling_exponential or 1) / G.GAME.starting_params.ante_scaling
end

local function scaling_voucher_unredeem(self, card)
    G.E_MANAGER:add_event(Event { func = function()
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.multiplier
        StrangeLib.dynablind.update_blind_scores()
        return true
    end })
end
SMODS.Voucher:take_ownership("pencil_half_chip", { unredeem = scaling_voucher_unredeem }, true)
SMODS.Voucher:take_ownership("pencil_vision", { unredeem = scaling_voucher_unredeem }, true)
SMODS.Voucher {
    key = "sqrt",
    atlas = "vouchers",
    pos = { x = 0, y = 2 },
    config = { exponent = 0.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.exponent } }
    end,
    requires = { "v_pencil_vision" },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event { func = function()
            G.GAME.starting_params.ante_scaling_exponential = (G.GAME.starting_params.ante_scaling_exponential or 1) *
                card.ability.exponent
            StrangeLib.dynablind.update_blind_scores()
            return true
        end })
    end,
    unredeem = function(self, card)
        G.E_MANAGER:add_event(Event { func = function()
            G.GAME.starting_params.ante_scaling_exponential = (G.GAME.starting_params.ante_scaling_exponential or 1) /
                card.ability.exponent
            StrangeLib.dynablind.update_blind_scores()
            return true
        end })
    end,
    pools = { Tier3 = true },
}
SMODS.Voucher:take_ownership("pencil_overstock", {
    unredeem = function(self, card)
        G.GAME.index_pack_bonus = G.GAME.index_pack_bonus - card.ability.extra
    end,
}, true)
