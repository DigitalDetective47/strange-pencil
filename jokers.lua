SMODS.Joker({
    key = "swimmers",
    config = { mult = 11 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
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
            return { mult = card.ability.mult }
        end
    end,
})

function lassCount()
    local queens = 0
    for k, v in ipairs(G.playing_cards or {}) do
        if v:is_suit("Clubs") and not SMODS.has_no_rank(v) and v.base.value == "Queen" then
            queens = queens + 1
        end
    end
    return queens
end

SMODS.Joker({
    key = "lass",
    config = { xmult_per_queen = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xmult_per_queen, math.max(lassCount() * card.ability.xmult_per_queen, 1) } }
    end,
    rarity = 3,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    cost = 7,
    pools = { clubs_pack = true },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and lassCount() * card.ability.xmult_per_queen > 1 then
            return { xmult = math.max(lassCount() * card.ability.xmult_per_queen, 1) }
        end
    end,
})

function forbidden_part_added(center, card, from_debuff)
    if not (G.GAME.won or G.GAME.win_notified)
    then
        for k, v in ipairs({ "j_pencil_forbidden_one", "j_pencil_left_arm", "j_pencil_left_leg", "j_pencil_right_arm", "j_pencil_right_leg" }) do
            if center.key ~= v and #SMODS.find_card(v) == 0 then
                return
            end
        end
        G.GAME.win_notified = true
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            blocking = false,
            blockable = false,
            func = (function()
                win_game()
                G.GAME.won = true
                return true
            end)
        }))
    end
end

SMODS.Joker({
    key = "forbidden_one",
    config = { payout = 4 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, SMODS.Centers.j_pencil_left_arm)
        table.insert(info_queue, SMODS.Centers.j_pencil_left_leg)
        table.insert(info_queue, SMODS.Centers.j_pencil_right_arm)
        table.insert(info_queue, SMODS.Centers.j_pencil_right_leg)
        return { vars = { card.ability.payout } }
    end,
    rarity = 1,
    pos = { x = 2, y = 1 },
    atlas = "jokers",
    cost = 8,
    add_to_deck = forbidden_part_added,
    calc_dollar_bonus = function(self, card)
        return card.ability.payout
    end
})
SMODS.Joker({
    key = "left_arm",
    config = { xchips = 2.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xchips } }
    end,
    rarity = 1,
    pos = { x = 3, y = 1 },
    atlas = "jokers",
    cost = 6,
    blueprint_compat = true,
    add_to_deck = forbidden_part_added,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xchips = card.ability.xchips }
        end
    end,
})
SMODS.Joker({
    key = "left_leg",
    config = { chips = 50 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    rarity = 1,
    pos = { x = 4, y = 1 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    add_to_deck = forbidden_part_added,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.chips }
        end
    end,
})
SMODS.Joker({
    key = "right_arm",
    config = { xmult = 1.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xmult } }
    end,
    rarity = 1,
    pos = { x = 1, y = 1 },
    atlas = "jokers",
    cost = 6,
    blueprint_compat = true,
    add_to_deck = forbidden_part_added,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = card.ability.xmult }
        end
    end,
})
SMODS.Joker({
    key = "right_leg",
    config = { mult = 10 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    rarity = 1,
    pos = { x = 0, y = 1 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    add_to_deck = forbidden_part_added,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.mult }
        end
    end,
})

SMODS.Joker({
    key = "doodlebob",
    config = { chips_per_index = 10 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.chips_per_index,
                G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.pencil_index and
                card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index or 0,
            }
        }
    end,
    rarity = 1,
    pos = { x = 2, y = 0 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.pencil_index and G.GAME.consumeable_usage_total.pencil_index > 0 then
            return { chips = card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index }
        elseif context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "index" then
            return { message = localize({ type = "variable", key = "a_chips", vars = { card.ability.chips_per_index * G.GAME.consumeable_usage_total.pencil_index } }) }
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
                        SMODS.add_card({ set = "index" })
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
        if context.repetition and context.cardarea == G.play and context.other_card.base.value == "4" then
            local repetitions = 0
            local juicers = {}
            local juice_i = 1
            for k, v in ipairs(G.hand.cards) do
                if v.base.value == "7" then
                    repetitions = repetitions + card.ability.factor
                    while #juicers < repetitions do
                        table.insert(juicers, v)
                    end
                end
            end
            return {
                repetitions = repetitions,
                card = card,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            juicers[juice_i]:juice_up(0.3, 0.5)
                            juice_i = juice_i + 1
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize("k_again_ex") }, card)
                end
            }
        end
    end,
})

if SMODS.Mods.Talisman and SMODS.Mods.Talisman.can_load then
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
                return { echips = card.ability.exponent }
            end
        end,
    })
end

SMODS.Joker({
    key = "pee_pants",
    rarity = 2,
    config = { scaling = 4, mult = 0, required_diamonds = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.scaling, card.ability.required_diamonds, card.ability.mult } }
    end,
    pos = { x = 5, y = 1 },
    atlas = "jokers",
    cost = 6,
    blueprint_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.mult }
        elseif context.before and not context.blueprint and next(context.poker_hands["Two Pair"]) then
            local diamonds = 0
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit("Diamonds") then
                    diamonds = diamonds + 1
                    if diamonds >= card.ability.required_diamonds then
                        card.ability.mult = card.ability.mult + card.ability.scaling
                        return { message = localize('k_upgrade_ex'), colour = G.C.MULT }
                    end
                end
            end
        end
    end,
})

SMODS.Joker({
    key = "jake",
    rarity = 3,
    config = { scaling = 1, xmult = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.scaling, card.ability.xmult }
        }
    end,
    pos = { x = 2, y = 2 },
    pixel_size = { w = 64, h = 86 },
    atlas = "jokers",
    cost = 9,
    blueprint_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = card.ability.xmult }
        elseif context.end_of_round and not (context.individual or context.repetition or context.blueprint) and G.GAME.blind.boss then
            card.ability.xmult = card.ability.xmult + card.ability.scaling
            return { message = localize("k_upgrade_ex") }
        end
    end,
})

SMODS.Joker({
    key = "squeeze",
    rarity = 1,
    config = { chance = 4, rounds = 0 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { G.GAME.probabilities.normal, card.ability.chance, card.ability.rounds }
        }
    end,
    pos = { x = 3, y = 2 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
            if pseudorandom('j_pencil_squeeze') < G.GAME.probabilities.normal / card.ability.chance then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.jokers:remove_card(card)
                        card:shatter()
                        return true
                    end
                }))
                return { message = localize('k_cracked') }
            else
                SMODS.calculate_effect({ message = localize("k_safe_ex") }, card)
                card.ability.rounds = card.ability.rounds + 1
                card.ability.extra_value = card.ability.extra_value + card.ability.rounds
                card:set_cost()
                delay(0.4)
                return { message = localize("k_val_up"), colour = G.C.MONEY }
            end
        end
    end,
})

SMODS.Joker({
    key = "eclipse",
    rarity = 2,
    config = { gain = 1, loss = 1, mult = 0 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.gain, card.ability.loss, card.ability.mult }
        }
    end,
    pos = { x = 4, y = 2 },
    atlas = "jokers",
    cost = 6,
    pools = { clubs_pack = true },
    blueprint_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and not context.blueprint then
            if context.other_card:is_suit("Clubs") then
                card.ability.mult = card.ability.mult + card.ability.gain
                return {
                    message = localize({ type = "variable", key = "a_mult", vars = { card.ability.gain } }),
                    message_card = card
                }
            end
            if context.other_card:is_suit("Hearts") and card.ability.mult ~= 0 then
                card.ability.mult = math.max(card.ability.mult - card.ability.loss, 0)
                return {
                    message = localize({ type = "variable", key = "a_mult_minus", vars = { card.ability.loss } }),
                    colour = G.C.RED,
                    message_card = card
                }
            end
        elseif context.joker_main then
            return { mult = card.ability.mult }
        end
    end,
})

SMODS.Joker({
    key = "club",
    rarity = 4,
    config = { xmult = 1.3, retriggers = 3, dead = false },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xmult, card.ability.retriggers } }
    end,
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    atlas = "jokers",
    pools = { clubs_pack = true },
    cost = 20,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not card.ability.dead then
            return { message = localize("k_again_ex"), repetitions = card.ability.retriggers, card = card }
        elseif context.cardarea == G.play and context.individual and not card.ability.dead then
            return { x_mult = card.ability.xmult }
        elseif context.before then
            for k, v in ipairs(context.full_hand) do
                if not v:is_suit("Clubs") then
                    card.ability.dead = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    delay(0.4)
                    return
                end
            end
        end
    end,
})

local calendar_date = os.date("*t")
local month_type = -1
if calendar_date.month == 4 or calendar_date.month == 6 or calendar_date.month == 9 or calendar_date.month == 11 then
    month_type = 13
elseif calendar_date.month ~= 2 then
    month_type = 20
elseif calendar_date.year % 4 == 0 and (calendar_date.year % 100 ~= 0 or calendar_date.year % 400 == 0) then
    month_type = 6
end

SMODS.Joker({
    key = "calendar",
    rarity = 1,
    config = { month = calendar_date.month, day = calendar_date.day },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.day, card.ability.month } }
    end,
    pos = { x = calendar_date.day - 1, y = month_type + calendar_date.wday },
    atlas = "calendar",
    immutable = true,
    cost = 5,
    pixel_size = { h = 59 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.day, mult = card.ability.month }
        end
    end,
})

SMODS.Sound({
    key = "doot",
    path = "doot.ogg"
})

SMODS.Joker({
    key = "doot",
    rarity = 1,
    config = { dollars = 5 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, SMODS.Centers.m_pencil_diseased)
        table.insert(info_queue, SMODS.Centers.m_pencil_flagged)
        return { vars = { card.ability.dollars } }
    end,
    pos = { x = 5, y = 2 },
    atlas = "jokers",
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before then
            local diseased = false
            local flagged = false
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, "m_pencil_diseased") then
                    diseased = true
                end
                if SMODS.has_enhancement(v, "m_pencil_flagged") then
                    flagged = true
                end
                if diseased and flagged then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("pencil_doot")
                            return true
                        end
                    }))
                    return { dollars = card.ability.dollars }
                end
            end
        end
    end,
})
if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
    table.insert(Cryptid.memepack, "j_pencil_doot")
end

function stonehenge_edition(self, card, func)
    card.ability.extra = func(self.ability.extra)
end

SMODS.Joker({
    key = "stonehenge",
    rarity = 1,
    config = { chips = 0, extra = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.chips } }
    end,
    pos = { x = 2, y = 3 },
    atlas = "jokers",
    cost = 6,
    blueprint_compat = true,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.chips = G.PROFILES[G.SETTINGS.profile].pencil_stonehenge or 0
    end,
    apply_glitched = stonehenge_edition,
    apply_oversat = stonehenge_edition,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.chips = card.ability.chips + card.ability.extra
            G.PROFILES[G.SETTINGS.profile].pencil_stonehenge = card.ability.chips
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, card)
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.chips }
        end
    end,
})
