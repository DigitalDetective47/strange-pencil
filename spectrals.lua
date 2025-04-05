SMODS.Consumable({
    key = "negative_space",
    set = "Spectral",
    pos = { x = 0, y = 0 },
    hidden = true,
    soul_set = "index",
    atlas = "spectrals",
    config = { multiplier = 1 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, { key = "eternal", set = "Other", vars = {} })
        table.insert(info_queue, G.P_CENTERS.e_negative)
        return { vars = { card.ability.multiplier } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                for _ = 1, G.jokers.config.card_limit * card.ability.multiplier, 1 do
                    local key
                    repeat
                        local _pool, _pool_key = get_current_pool("Joker")
                        key = pseudorandom_element(_pool, pseudoseed(_pool_key))
                    until G.P_CENTERS[key] and G.P_CENTERS[key].eternal_compat
                    SMODS.add_card({ key = key, no_edition = true, edition = "e_negative", stickers = { "eternal" } })
                end
                play_sound("timpani")
                return true
            end
        }))
    end,
})

---@return string handname the current most played hand
local function pulsar_target()
    local most, played
    for _, hand_key in ipairs(G.handlist) do
        if G.GAME.hands[hand_key].visible then
            if not played or G.GAME.hands[hand_key].played > played then
                most = hand_key
                played = G.GAME.hands[hand_key].played
            end
        end
    end
    return most
end

SMODS.Consumable({
    key = "pulsar",
    set = "Spectral",
    pos = { x = 1, y = 0 },
    hidden = true,
    soul_set = "Planet",
    atlas = "spectrals",
    config = { factor = 2 },
    loc_vars = function(self, info_queue, card)
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
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area)
        local hand_key = pulsar_target()
        local hand_center = G.GAME.hands[hand_key]
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
                handname = localize(hand_key, 'poker_hands'),
                chips = hand_center.chips,
                mult = hand_center.mult,
                level = hand_center.level
            })
        level_up_hand(card, hand_key, false, hand_center.level * (card.ability.factor - 1))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end,
})
