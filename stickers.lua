local function roll_paralysis(sticker, card)
    local hit = pseudorandom(sticker.key) < G.GAME.probabilities.normal / card.ability.pencil_paralyzed.chance
    SMODS.debuff_card(card, hit, sticker.key)
    if hit then
        return { message = localize("k_paralyzed_ex"), colour = sticker.badge_colour }
    end
end

SMODS.Sticker({
    key = "paralyzed",
    atlas = "stickers",
    pos = {
        x = next(SMODS.find_mod("Cryptid")) and 1 or 0, --don't overlap with Banana
        y = 0,
    },
    config = { chance = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability[self.key].chance } }
    end,
    badge_colour = G.C.YELLOW,
    default_compat = true,
    needs_enable_flag = true,
    apply = function(self, card, val)
        if val then
            card.ability[self.key] = copy_table(self.config)
            SMODS.calculate_effect(roll_paralysis(self, card) or {}, card)
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
