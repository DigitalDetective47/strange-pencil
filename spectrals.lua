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
                        key = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed(seed or "grc")).key,
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
                            key = pseudorandom_element(G.P_CENTER_POOLS.Booster, pseudoseed(seed or "grc")).key,
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

if (SMODS.Mods["TSpectrals"] or {}).can_load then
    AltTexture({
        key = "TSpectrals_spectrals",
        set = "Spectral",
        path = "TSpectrals/spectrals.png",
        keys = {
            "c_pencil_negative_space",
        }
    })
    table.insert(TexturePacks.texpack_tspa_spectrans.textures, "pencil_TSpectrals_spectrals")
end
if (SMODS.Mods["LeSpectrals"] or {}).can_load then
    AltTexture({
        key = "LeSpectrals_spectrals",
        set = "Spectral",
        path = "LeSpectrals/spectrals.png",
        keys = {
            "c_pencil_negative_space",
        }
    })
    table.insert(TexturePacks.texpack_lspa_LeSpectrals.textures, "pencil_LeSpectrals_spectrals")
end
