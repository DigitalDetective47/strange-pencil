SMODS.Consumable {
    key = "negative_space",
    set = "Spectral",
    pos = { x = 0, y = 0 },
    cost = G.P_CENTERS.c_soul.cost,
    hidden = true,
    soul_set = "index",
    atlas = "spectrals",
    config = { multiplier = 1 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, { key = "eternal", set = "Other", vars = {} })
        table.insert(info_queue, G.P_CENTERS.e_negative)
        return { vars = { card.ability.multiplier } }
    end,
    can_use = StrangeLib.consumable.use_templates.always_usable,
    use = function(self, card, area)
        G.E_MANAGER:add_event(Event { trigger = "after", delay = 0.4, func = function()
            for _ = 1, G.jokers.config.card_limit * card.ability.multiplier do
                local key
                repeat
                    local _pool, _pool_key = get_current_pool("Joker")
                    key = pseudorandom_element(_pool, pseudoseed(_pool_key))
                until G.P_CENTERS[key] and G.P_CENTERS[key].eternal_compat
                SMODS.add_card { key = key, no_edition = true, edition = "e_negative", stickers = { "eternal" }, force_stickers = true }
            end
            play_sound("timpani")
            return true
        end })
    end,
}

---@return string handname the current most played hand
local function pulsar_target()
    local most, played
    for _, hand_key in ipairs(G.handlist) do
        if SMODS.is_poker_hand_visible(hand_key) then
            if not played or G.GAME.hands[hand_key].played > played then
                most = hand_key
                played = G.GAME.hands[hand_key].played
            end
        end
    end
    return most
end

SMODS.Consumable {
    key = "pulsar",
    set = "Spectral",
    pos = { x = 1, y = 0 },
    cost = G.P_CENTERS.c_black_hole.cost,
    hidden = true,
    soul_set = "Planet",
    atlas = "spectrals",
    config = { factor = 2 },
    loc_vars = function(self, info_queue, card)
        ---@type string
        local mult_text
        if card.ability.factor == 2 then
            mult_text = "Double"
        elseif card.ability.factor == 3 then
            mult_text = "Triple"
        elseif card.ability.factor == 4 then
            mult_text = "Quadruple"
        else
            mult_text = "X" .. card.ability.factor .. " to"
        end
        return { vars = { mult_text, localize(pulsar_target(), "poker_hands") } }
    end,
    can_use = StrangeLib.consumable.use_templates.always_usable,
    use = function(self, card, area)
        ---@type string
        local hand = pulsar_target()
        SMODS.upgrade_poker_hands { hands = hand, level_up = G.GAME.hands[hand].level * (card.ability.factor - 1), from = card }
    end,
}
