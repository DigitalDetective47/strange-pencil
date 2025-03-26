local clubs_create_card_hook = SMODS.Centers.p_pencil_clubs.create_card
local function clubs_create_card(self, card, i)
    if G.GAME.modifiers.cry_force_enhancement and (G.GAME.modifiers.cry_force_enhancement == "m_stone" or G.P_CENTERS[G.GAME.modifiers.cry_force_enhancement].no_suit) then
        local rng = pseudorandom('pencil_clubs_pack')
        if rng > 0.997 then
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
Cryptid.edeck_sprites.sticker.pencil_paralyzed = { atlas = "pencil_stickers", pos = { x = 2, y = 0 } }

SMODS.Sticker:take_ownership("pencil_paralyzed", { pos = { x = 1, y = 0 } }, true) --don't overlap with Banana

local blind_score_hook = StrangeLib.dynablind.get_blind_score
function StrangeLib.dynablind.get_blind_score(blind, base)
    G.GAME.modifiers.scaling = G.GAME.modifiers.scaling or 1
    return blind_score_hook(blind, base or
        (SMODS.get_blind_amount(G.GAME.round_resets.blind_ante) * G.GAME.starting_params.ante_scaling) ^
        (G.GAME.starting_params.ante_scaling_exponential or 1))
end

SMODS.Voucher({
    key = "sqrt",
    atlas = "vouchers",
    pos = { x = 0, y = 2 },
    config = { exponent = 0.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.exponent } }
    end,
    requires = { "v_pencil_vision" },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.starting_params.ante_scaling_exponential = (G.GAME.starting_params.ante_scaling_exponential or 1) *
                    card.ability.exponent
                StrangeLib.dynablind.update_blind_scores()
                return true
            end,
        }))
    end,
    unredeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.starting_params.ante_scaling_exponential = (G.GAME.starting_params.ante_scaling_exponential or 1) /
                    card.ability.exponent
                StrangeLib.dynablind.update_blind_scores()
                return true
            end,
        }))
    end,
    pools = { Tier3 = true },
})
