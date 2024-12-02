SMODS.Atlas({
    key = "spectrals",
    path = "spectrals.png",
    px = 71,
    py = 95,
})

SMODS.Consumable({
    key = "negative_space",
    set = "Spectral",
    pos = { x = 0, y = 0 },
    hidden = true,
    soul_set = "index",
    atlas = "spectrals",
    config = { multiplier = 1 },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { key = "eternal", set = "Other", vars = {} })
        table.insert(info_queue, G.P_CENTERS.e_negative)
        return { vars = { self.config.multiplier } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                for _ = 1, G.jokers.config.card_limit * self.config.multiplier, 1 do
                    local card = nil
                    repeat
                        if card then
                            card:remove()
                        end
                        card = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            set = "Joker",
                        })
                        card:set_eternal(true)
                    until card.ability.eternal
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
                for _ = 1, G.consumeables.config.card_limit * self.config.multiplier, 1 do
                    local card = SMODS.create_card({
                        no_edition = true,
                        edition = "e_negative",
                        -- stickers = { "eternal" },
                        area = G.consumeables,
                        key = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed(seed or "grc")).key,
                    })
                    card.ability.eternal = true
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                end
                if G.STATE == G.STATES.SELECTING_HAND then
                    for _ = 1, G.hand.config.card_limit * self.config.multiplier, 1 do
                        local card = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            set = "Enhanced",
                            area = G.consumeables,
                        })
                        card.ability.eternal = true
                        card:add_to_deck()
                        G.hand:emplace(card)
                    end
                end
                if G.shop_jokers ~= nil then
                    for _ = 1, G.shop_jokers.config.card_limit * self.config.multiplier, 1 do
                        local card = nil
                        repeat
                            if card then
                                card:remove()
                            end
                            card = create_card_for_shop(G.shop_jokers)
                            card:set_eternal(true)
                            card:set_edition("e_negative")
                        until card.ability.eternal
                        card.cost = 0
                        card:add_to_deck()
                        G.shop_jokers:emplace(card)
                    end
                end
                if G.shop_booster ~= nil then
                    for _ = 1, G.shop_booster.config.card_limit * self.config.multiplier, 1 do
                        local card = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            area = G.shop_booster,
                            key = pseudorandom_element(G.P_CENTER_POOLS.Booster, pseudoseed(seed or "grc")).key,
                        })
                        card.ability.eternal = true
                        card.cost = 0
                        card:add_to_deck()
                        create_shop_card_ui(card, 'Booster', G.shop_booster)
                        G.shop_booster:emplace(card)
                    end
                end
                if G.shop_vouchers ~= nil then
                    for _ = 1, G.shop_vouchers.config.card_limit * self.config.multiplier, 1 do
                        local card = SMODS.create_card({
                            no_edition = true,
                            edition = "e_negative",
                            -- stickers = { "eternal" },
                            area = G.shop_voucher,
                            key = get_next_voucher_key(true),
                        })
                        card.ability.eternal = true
                        card.cost = 0
                        card:add_to_deck()
                        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
                        G.shop_vouchers:emplace(card)
                    end
                end
                play_sound("timpani")
                return true
            end
        }))
    end,
})
