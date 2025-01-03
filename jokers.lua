SMODS.Atlas({
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
})

SMODS.Joker({
    key = "swimmers",
    config = { mult = 11 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.mult,
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
                message = localize({ type = "variable", key = "a_mult", vars = { card.ability.mult } }),
                mult = card.ability.mult,
                card = card,
            }
        end
    end,
})

function lassCount()
    local queens = 0
    for k, v in ipairs(G.playing_cards or {}) do
        if v:is_suit("Clubs") and v.base.id == 12 then
            queens = queens + 1
        end
    end
    return queens
end

SMODS.Joker({
    key = "lass",
    config = { xmult_per_queen = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.xmult_per_queen,
                math.max(lassCount() * card.ability.xmult_per_queen, 1),
            },
        }
    end,
    rarity = 3,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and lassCount() * card.ability.xmult_per_queen > 1 then
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { math.max(lassCount() * card.ability.xmult_per_queen, 1) } }),
                Xmult_mod = math.max(lassCount() * card.ability.xmult_per_queen, 1),
            }
        end
    end,
})

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Epic Jokers"] and SMODS.Mods.Cryptid.config["Code Cards"] then
    SMODS.Joker({
        key = "forbidden_one",
        config = { payout = 4 },
        loc_vars = function(self, info_queue, card)
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
                    card.ability.payout,
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
                    if v.ability.pencil_forbidden_left_arm then
                        has_left_arm = true
                    elseif v.ability.pencil_forbidden_right_arm then
                        has_right_arm = true
                    elseif v.ability.pencil_forbidden_left_leg then
                        has_left_leg = true
                    elseif v.ability.pencil_forbidden_right_leg then
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
            return card.ability.payout
        end
    })
    SMODS.Joker({
        key = "left_arm",
        config = { xchips = 2.5, pencil_forbidden_left_arm = true },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.xchips,
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
                    message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.xchips } }),
                    colour = G.C.CHIPS,
                    Xchip_mod = card.ability.xchips,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "left_leg",
        config = { chips = 50, pencil_forbidden_left_leg = true },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.chips },
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
                    message = localize({ type = "variable", key = "a_chips", vars = { card.ability.chips } }),
                    chip_mod = card.ability.chips,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "right_arm",
        config = { xmult = 1.5, pencil_forbidden_right_arm = true },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.xmult,
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
                    message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.xmult } }),
                    Xmult_mod = card.ability.xmult,
                }
            end
        end,
    })
    SMODS.Joker({
        key = "right_leg",
        config = { mult = 10, pencil_forbidden_right_leg = true },
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.mult },
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
                    message = localize({ type = "variable", key = "a_mult", vars = { card.ability.mult } }),
                    mult_mod = card.ability.mult,
                }
            end
        end,
    })
end

SMODS.Joker({
    key = "doodlebob",
    config = { chips_per_index = 10 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.chips_per_index,
                G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.pencil_index and
                card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index or 0,
            },
        }
    end,
    rarity = 1,
    pos = { x = 2, y = 0 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.pencil_index and G.GAME.consumeable_usage_total.pencil_index > 0 then
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index } }),
                chip_mod = card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index,
            }
        elseif context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "index" then
            card_eval_status_text(card, "extra", nil, nil, nil,
                { message = localize({ type = "variable", key = "a_chips", vars = { card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index } }) })
        end
    end,
})

SMODS.Joker({
    key = "pencil",
    rarity = 4,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    atlas = "jokers",
    cost = 20,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set ~= "index" then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local new = SMODS.create_card({ set = "index" })
                        new:add_to_deck()
                        G.consumeables:emplace(new)
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
    end,
})

SMODS.Joker({
    key = "forty_seven",
    rarity = 3,
    config = { factor = 1 },
    loc_vars = function(self, info_queue, card)
        if card.ability.factor == 1 then
            return { vars = { "once" } }
        elseif card.ability.factor == 2 then
            return { vars = { "twice" } }
        elseif card.ability.factor == 3 then
            return { vars = { "thrice" } }
        else
            return { vars = { card.ability.factor .. " times" } }
        end
    end,
    pos = { x = 5, y = 0 },
    atlas = "jokers",
    cost = 11,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.base.id == 4 then
            local repetitions = 0
            for k, v in ipairs(G.hand.cards) do
                if v.base.id == 7 then
                    repetitions = repetitions + 1
                    -- G.E_MANAGER:add_event(Event({
                    --     trigger = 'after',
                    --     delay = 0.4,
                    --     func = function()
                    --         v:juice_up(0.3, 0.5)
                    --         return true
                    --     end
                    -- }))
                end
            end
            return { message = localize("k_again_ex"), repetitions = repetitions, card = card }
        end
    end,
})

if (SMODS.Mods["Talisman"] or {}).can_load then
    SMODS.Joker({
        key = "square",
        rarity = 4,
        config = { exponent = 2 },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.exponent } }
        end,
        pos = { x = 0, y = 2 },
        soul_pos = { x = 1, y = 2 },
        atlas = "jokers",
        cost = 20,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize({ type = "variable", key = "a_powchips", vars = { card.ability.exponent } }),
                    Echip_mod = card.ability.exponent
                }
            end
        end,
    })
end
