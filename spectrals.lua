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
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                for _ = 1, G.jokers.config.card_limit * card.ability.multiplier, 1 do
                    local new = nil
                    repeat
                        if new then
                            new:remove()
                        end
                        new = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            set = "Joker",
                        })
                        new:set_eternal(true)
                    until new.ability.eternal
                    new:add_to_deck()
                    G.jokers:emplace(new)
                end
                for _ = 1, G.consumeables.config.card_limit * card.ability.multiplier, 1 do
                    local new = SMODS.create_card({
                        no_edition = true,
                        edition = "e_negative",
                        -- stickers = { "eternal" },
                        area = G.consumeables,
                        key = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed(self.key)).key,
                    })
                    new.ability.eternal = true
                    new:add_to_deck()
                    G.consumeables:emplace(new)
                end
                if #G.hand.cards ~= 0 then
                    for _ = 1, G.hand.config.card_limit * card.ability.multiplier, 1 do
                        local new = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            set = "Enhanced",
                            area = G.consumeables,
                        })
                        new.ability.eternal = true
                        new:add_to_deck()
                        G.hand:emplace(new)
                    end
                end
                if G.shop_jokers ~= nil then
                    for _ = 1, G.shop_jokers.config.card_limit * card.ability.multiplier, 1 do
                        local new = nil
                        repeat
                            if new then
                                new:remove()
                            end
                            new = create_card_for_shop(G.shop_jokers)
                            new:set_eternal(true)
                            new:set_edition("e_negative")
                        until new.ability.eternal
                        new.cost = 0
                        new:add_to_deck()
                        G.shop_jokers:emplace(new)
                    end
                end
                if G.shop_booster ~= nil then
                    for _ = 1, G.shop_booster.config.card_limit * card.ability.multiplier, 1 do
                        local new = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            area = G.shop_booster,
                            key = pseudorandom_element(G.P_CENTER_POOLS.Booster, pseudoseed(self.key)).key,
                        })
                        new.ability.eternal = true
                        new.cost = 0
                        new:add_to_deck()
                        create_shop_card_ui(new, 'Booster', G.shop_booster)
                        G.shop_booster:emplace(new)
                    end
                end
                if G.shop_vouchers ~= nil then
                    for _ = 1, G.shop_vouchers.config.card_limit * card.ability.multiplier, 1 do
                        local new = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            area = G.shop_voucher,
                            key = get_next_voucher_key(true),
                        })
                        new.ability.eternal = true
                        new.cost = 0
                        new:add_to_deck()
                        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                        create_shop_card_ui(new, 'Voucher', G.shop_vouchers)
                        G.shop_vouchers:emplace(new)
                    end
                end
                play_sound("timpani")
                return true
            end
        }))
    end,
})

local function pulsar_target()
    local most, played
    for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible then
            if not played or G.GAME.hands[v].played > played then
                most = v
                played = G.GAME.hands[v].played
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
    use = function(self, card, area, copier)
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
