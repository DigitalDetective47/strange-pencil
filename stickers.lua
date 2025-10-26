---@param sticker SMODS.Sticker
---@param card Card
---@return table? effect
local function roll_paralysis(sticker, card)
    local hit = SMODS.pseudorandom_probability(card, sticker.key, 1, card.ability.pencil_paralyzed.chance)
    SMODS.debuff_card(card, hit, sticker.key)
    if hit then
        return { message = localize("k_paralyzed_ex"), colour = sticker.badge_colour }
    end
end

SMODS.Sticker({
    key = "paralyzed",
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    config = { chance = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability[self.key].chance } }
    end,
    badge_colour = G.C.YELLOW,
    default_compat = true,
    sets = { Joker = true },
    needs_enable_flag = true,
    apply = function(self, card, val)
        if val then
            card.ability[self.key] = copy_table(self.config)
            if not G.your_collection then
                SMODS.calculate_effect(roll_paralysis(self, card) or {}, card)
            end
        else
            card.ability[self.key] = val
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == card.area and not context.game_over then
            return roll_paralysis(self, card)
        end
    end,
})
