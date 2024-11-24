SMODS.Atlas({
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
})

SMODS.Joker({
    key = "swimmers",
    config = { extra = { mult = 11 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult,
            },
        }
    end,
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            local enhancement = nil;
            for i = 1, #context.scoring_hand do
                if enhancement then
                    if context.scoring_hand[i].ability.name ~= enhancement then
                        return {}
                    end
                elseif context.scoring_hand[i].ability.name ~= "Default Base" then
                    enhancement = context.scoring_hand[i].ability.name
                else
                    return {}
                end
            end
            return {
                message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
                mult = card.ability.extra.mult,
                card = card,
            }
        end
    end,
})

SMODS.Joker({
    key = "lass",
    config = { extra = { xmult = 1, xmult_per_queen = 1 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.xmult_per_queen,
                center.ability.extra.xmult,
            },
        }
    end,
    rarity = 3,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    cost = 7,
    blueprint_compat = true,
    update = function(self, card, dt)
        card.ability.extra.xmult = 0
        for k, v in ipairs(G.playing_cards or {}) do
            if v.base.suit == "Clubs" and v.base.id == 12 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_per_queen
            end
        end
        card.ability.extra.xmult = math.max(card.ability.extra.xmult, 1)
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
                Xmult_mod = card.ability.extra.xmult,
            }
        end
    end,
})

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Epic Jokers"] and SMODS.Mods.Cryptid.config["Code Cards"] then
    SMODS.Joker({
        SMODS.Joker({
            key = "forbidden_one",
            config = { extra = { payout = 4 } },
            loc_vars = function(self, info_queue, center)
                table.insert(info_queue, { key = "j_pencil_left_arm", set = "Joker", specific_vars = { 2.5 } })
                table.insert(info_queue, { key = "j_pencil_right_arm", set = "Joker", specific_vars = { 1.5 } })
                table.insert(info_queue, { key = "j_pencil_left_leg", set = "Joker", specific_vars = { 50 } })
                table.insert(info_queue, { key = "j_pencil_right_leg", set = "Joker", specific_vars = { 10 } })
                table.insert(info_queue, G.P_CENTERS.e_negative)
                table.insert(info_queue, { key = "cry_rigged", set = "Other", vars = {} })
                table.insert(info_queue,
                    { key = "j_cry_googol_play", set = "Joker", specific_vars = { tostring(G.GAME and G.GAME.probabilities.normal or 1), 8, 1e100 } })
                return {
                    vars = {
                        center.ability.extra.payout,
                    },
                }
            end,
            rarity = "cry_epic",
            pos = { x = 2, y = 1 },
            atlas = "jokers",
            cost = 10,
            calculate = function(self, card, context)
                if context.setting_blind and not context.blueprint then
                    local has_left_arm = false
                    local has_right_arm = false
                    local has_left_leg = false
                    local has_right_leg = false
                    for k, v in ipairs(G.jokers.cards) do
                        if v.ability.extra.pencil_forbidden_left_arm then
                            has_left_arm = true
                        elseif v.ability.extra.pencil_forbidden_right_arm then
                            has_right_arm = true
                        elseif v.ability.extra.pencil_forbidden_left_leg then
                            has_left_leg = true
                        elseif v.ability.extra.pencil_forbidden_right_leg then
                            has_right_leg = true
                        end
                    end
                    if has_left_arm and has_right_arm and has_left_leg and has_right_leg then
                        local googol = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_googol_play")
                        googol:set_edition("e_negative", true, nil, true)
                        googol:add_to_deck()
                        SMODS.Stickers.cry_rigged:apply(googol, true)
                        G.jokers:emplace(googol)
                        return {
                            card = card,
                        }
                    end
                end
            end,
            calc_dollar_bonus = function(self, card)
                return 4
            end
        }),
        key = "left_arm",
        config = { extra = { xchips = 2.5, pencil_forbidden_left_arm = true } },
        loc_vars = function(self, info_queue, center)
            return {
                vars = {
                    center.ability.extra.xchips,
                },
            }
        end,
        rarity = 2,
        pos = { x = 3, y = 1 },
        atlas = "jokers",
        cost = 6,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.xchips } }),
                    colour = G.C.CHIPS,
                    Xchip_mod = card.ability.extra.xchips,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "left_leg",
        name = "pencil_left_leg",
        config = { extra = { chips = 50, pencil_forbidden_left_leg = true } },
        loc_vars = function(self, info_queue, center)
            return {
                vars = { center.ability.extra.chips },
            }
        end,
        rarity = 2,
        pos = { x = 4, y = 1 },
        atlas = "jokers",
        cost = 5,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
                    chip_mod = card.ability.extra.chips,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "right_leg",
        name = "pencil_right_leg",
        config = { extra = { mult = 10, pencil_forbidden_right_leg = true } },
        loc_vars = function(self, info_queue, center)
            return {
                vars = { center.ability.extra.mult },
            }
        end,
        rarity = 2,
        pos = { x = 0, y = 1 },
        atlas = "jokers",
        cost = 5,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
                    mult_mod = card.ability.extra.mult,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "right_arm",
        config = { extra = { xmult = 1.5, pencil_forbidden_right_arm = true } },
        loc_vars = function(self, info_queue, center)
            return {
                vars = {
                    center.ability.extra.xmult,
                },
            }
        end,
        rarity = 2,
        pos = { x = 1, y = 1 },
        atlas = "jokers",
        cost = 6,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }),
                    Xmult_mod = card.ability.extra.xmult,
                }
            end
        end,
    })
end

SMODS.Joker({
    key = "doodlebob",
    config = { chips_per_index = 10 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.chips_per_index,
                G.GAME.consumeable_usage_total.pencil_index and
                center.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index or 0,
            },
        }
    end,
    rarity = 1,
    pos = { x = 2, y = 0 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.consumeable_usage_total.pencil_index and G.GAME.consumeable_usage_total.pencil_index > 0 then
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { center.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index } }),
                chip_mod = center.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index,
            }
        elseif context.using_consumable and not context.blueprint and (context.consumeable.ability.set == "pencil_index") then
            return {
                message = localize({ type = 'variable', key = 'a_chips', vars = { center.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index } }),
            }
        end
    end,
})
