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
            for _, other_card in ipairs(context.scoring_hand) do
                if enhancement then
                    if other_card.ability.name ~= enhancement then
                        return
                    end
                elseif other_card.ability.name ~= "Default Base" then
                    enhancement = other_card.ability.name
                else
                    return
                end
            end
            return { mult = card.ability.mult }
        end
    end,
})

---Return the number of Queens of Clubs in the player's full deck
---@return integer
local function lassCount()
    local queens = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card:is_suit("Clubs") and not SMODS.has_no_rank(card) and card.base.value == "Queen" then
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
    in_pool = function(self, args)
        return lassCount() > 1
    end,
    pools = { clubs_pack = true },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and lassCount() * card.ability.xmult_per_queen > 1 then
            return { xmult = math.max(lassCount() * card.ability.xmult_per_queen, 1) }
        end
    end,
})

---Automatically win the game if the player has all 5 parts of The Forbidden One
---@param center SMODS.Center
---@param card Card
---@param from_debuff boolean
local function forbidden_part_added(center, card, from_debuff)
    if not (G.GAME.won or G.GAME.win_notified)
    then
        for _, key in ipairs({ "j_pencil_forbidden_one", "j_pencil_left_arm", "j_pencil_left_leg", "j_pencil_right_arm", "j_pencil_right_leg" }) do
            if center.key ~= key and #SMODS.find_card(key) == 0 then
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
    rarity = 2,
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
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.base.value == "4" then
            local repetitions = 0
            local juicers = {}
            local juice_i = 1
            for _, other_card in ipairs(G.hand.cards) do
                if other_card.base.value == "7" then
                    repetitions = repetitions + card.ability.factor
                    while #juicers < repetitions do
                        table.insert(juicers, other_card)
                    end
                end
            end
            return {
                remove_default_message = true,
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

if not next(SMODS.find_mod("Talisman")) then
    SMODS.Sound({
        key = "echips",
        path = "echips.wav"
    })
end

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
                fchips = function(chips)
                    return chips ^ card.ability.exponent
                end,
                message = localize({ type = "variable", key = "a_echips", vars = { card.ability.exponent } }),
                sound = "pencil_echips",
                colour = G.C.CHIPS,
            }
        end
    end,
})

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
            for _, other_card in ipairs(context.scoring_hand) do
                if other_card:is_suit("Diamonds") then
                    diamonds = diamonds + 1
                    if diamonds >= card.ability.required_diamonds then
                        SMODS.scale_card(card, {
                            ref_table = card.ability,
                            ref_value = "mult",
                            scalar_value = "scaling",
                            message_colour = G.C.MULT,
                        })
                    end
                end
            end
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
            if SMODS.pseudorandom_probability(card, 'j_pencil_squeeze', 1, card.ability.chance) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.jokers:remove_card(card)
                        card:shatter()
                        return true
                    end
                }))
                return { message = localize('k_cracked_ex') }
            else
                card.ability.rounds = card.ability.rounds + 1
                card.ability.extra_value = card.ability.extra_value + card.ability.rounds
                card:set_cost()
                delay(0.4)
                return {
                    message = localize("k_safe_ex"),
                    extra = { message = localize("k_val_up"), colour = G.C.MONEY },
                }
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
                SMODS.scale_card(card,
                    {
                        ref_table = card.ability,
                        ref_value = "mult",
                        scalar_value = "gain",
                        no_message = true,
                    })
                return {
                    message = localize({ type = "variable", key = "a_mult", vars = { card.ability.gain } }),
                    message_card = card,
                    colour = G.C.MULT
                }
            end
            if context.other_card:is_suit("Hearts") and card.ability.mult ~= 0 then
                SMODS.scale_card(card,
                    {
                        ref_table = card.ability,
                        ref_value = "mult",
                        scalar_value = "loss",
                        operation = "-",
                        no_message = true,
                    })
                return {
                    message = localize({ type = "variable", key = "a_mult_minus", vars = { card.ability.loss } }),
                    message_card = card,
                    colour = G.C.RED
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
    pools = { clubs_legendary = true },
    cost = 20,
    blueprint_compat = true,
    eternal_compat = false,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not card.ability.dead then
            return { repetitions = card.ability.retriggers, card = card }
        elseif context.cardarea == G.play and context.individual and not card.ability.dead then
            return { x_mult = card.ability.xmult }
        elseif context.before then
            for _, other_card in ipairs(context.full_hand) do
                if not other_card:is_suit("Clubs") then
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
    display_size = { h = 59 },
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
    in_pool = function(self, args)
        local diseased = false
        local flagged = false
        for _, other_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(other_card, "m_pencil_diseased") then
                diseased = true
            end
            if SMODS.has_enhancement(other_card, "m_pencil_flagged") then
                flagged = true
            end
            if diseased and flagged then
                return true
            end
        end
    end,
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before then
            local diseased = false
            local flagged = false
            for _, other_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(other_card, "m_pencil_diseased") then
                    diseased = true
                end
                if SMODS.has_enhancement(other_card, "m_pencil_flagged") then
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
    pools = { Meme = true }
})

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
    set_ability = function(self, card)
        card.ability.chips = G.PROFILES[G.SETTINGS.profile].pencil_stonehenge or 0
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "chips",
                scalar_value = "extra",
                message_colour = G.C.CHIPS
            })
            G.PROFILES[G.SETTINGS.profile].pencil_stonehenge = card.ability.chips
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { chips = card.ability.chips }
        end
    end,
})

---Calculate the values used by Ratio<br>
---Returns `nil` if multiple suits are tied for most common
---@return string? suit the most common suit in the deck
---@return number? ratio the proportion of the deck that is that suit
local function calc_ratio()
    if not G.playing_cards then
        return
    end
    local tallies = {}
    for _, card in ipairs(G.playing_cards) do
        tallies[card.base.suit] = (tallies[card.base.suit] or 0) + 1
    end
    local most = nil
    local active = false
    for k, v in pairs(tallies) do
        if not most or v > tallies[most] then
            most = k
            active = true
        elseif v == tallies[most] then
            active = false
        end
    end
    if active then
        return most, tallies[most] / #G.playing_cards
    end
end

SMODS.Joker({
    key = "ratio",
    rarity = 2,
    config = { xmult = 1 },
    loc_vars = function(self, info_queue, card)
        local suit
        local ratio
        suit, ratio = calc_ratio()
        if not suit then
            ratio = 0
        end
        return { vars = { suit and localize(suit, "suits_plural") or "Inactive", ratio, card.ability.xmult, colours = { suit and G.C.SUITS[suit] or G.C.IMPORTANT } } }
    end,
    pos = { x = 2, y = 2 },
    atlas = "jokers",
    cost = 7,
    blueprint_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local suit
            local ratio
            suit, ratio = calc_ratio()
            if not suit then
                return
            end
            for _, other_card in ipairs(context.scoring_hand) do
                if other_card:is_suit(suit) then
                    card.ability.xmult = 1
                    return { message = localize('k_reset'), colour = G.C.MULT }
                end
            end
            SMODS.scale_card(card,
                {
                    ref_table = card.ability,
                    ref_value = "xmult",
                    scalar_table = { ratio },
                    scalar_value = 1,
                    message_colour = G.C.MULT,
                    message_key = "a_xmult",
                })
        elseif context.joker_main then
            return { xmult = card.ability.xmult }
        end
    end,
})

SMODS.Joker({
    key = "commie",
    rarity = 2,
    pos = { x = 3, y = 3 },
    atlas = "jokers",
    cost = 9,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local targets = {}
            local target_total = 0
            for _, other in ipairs(context.scoring_hand) do
                if not SMODS.has_no_rank(other) then
                    table.insert(targets, other)
                    target_total = target_total + other.base.nominal
                end
            end
            if #targets > 0 then
                local ranks = {}
                for _, rank in pairs(SMODS.Ranks) do
                    table.insert(ranks, rank)
                end
                table.sort(ranks, function(a, b)
                    return a.nominal == b.nominal and (a.face_nominal or 0) > (b.face_nominal or 0) or
                        a.nominal < b.nominal
                end)
                target_total = target_total / #targets
                local target_rank = ranks[#ranks]
                for k, v in ipairs(ranks) do
                    if target_total < v.nominal then
                        if k <= 1 then
                            sendErrorMessage("Mathematical paradox detected! Aborting calculation...", self.key)
                            return { message = "ERROR" }
                        else
                            target_rank = ranks[k - 1]
                            break
                        end
                    end
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _, target in ipairs(targets) do
                            local succ, msg = SMODS.change_base(target, nil, target_rank.key)
                            if not succ then
                                sendErrorMessage(msg)
                            end
                        end
                        play_sound("gong", 0.94, 0.3)
                        play_sound("gong", 0.94 * 1.5, 0.2)
                        play_sound("tarot1", 1.5)
                        return true
                    end
                }))
                return { message = localize("k_balanced"), volume = 0, colour = { 0.8, 0.45, 0.85, 1 } }
            end
        end
    end,
})

SMODS.Joker({
    key = "night_club",
    rarity = 3,
    pos = { x = 4, y = 3 },
    atlas = "jokers",
    cost = 7,
    pools = { clubs_pack = true },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_left == 0 and not context.blueprint then
            for _, played_card in ipairs(context.scoring_hand) do
                local succ, msg = SMODS.change_base(played_card, "Clubs", nil)
                if not succ then
                    sendErrorMessage(msg)
                end
            end
            return { message = localize("k_clubbin_ex"), colour = G.C.SUITS.Clubs }
        end
    end,
})

SMODS.Sound({
    key = "fizzle",
    path = "fizzle.wav"
})

SMODS.Joker({
    key = "fizzler",
    rarity = 1,
    config = { mult = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    pos = { x = 5, y = 3 },
    atlas = "jokers",
    cost = 4,
    blueprint_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local prev_mult = card.ability.mult
            local destroy_queue = {}
            for _, consumable in ipairs(G.consumeables.cards) do
                if not SMODS.is_eternal(consumable, card) then
                    card.ability.mult = card.ability.mult + consumable.sell_cost
                    table.insert(destroy_queue, consumable)
                end
            end
            if card.ability.mult ~= prev_mult then
                return {
                    message = localize({ type = 'variable', key = 'a_mult', vars = { card.ability.mult - prev_mult } }),
                    colour = { 0, 0.5, 1, 1 },
                    sound = "pencil_fizzle",
                    func = function()
                        for _, consumable in ipairs(destroy_queue) do
                            consumable:start_dissolve({ { 0, 0.5, 1, 1 } }, true)
                        end
                    end,
                }
            end
        elseif context.joker_main and card.ability.mult >= 0 then
            return { mult = card.ability.mult }
        end
    end,
})

SMODS.Joker({
    key = "cell",
    rarity = 2,
    pos = { x = 0, y = 4 },
    atlas = "jokers",
    cost = 7,
    blueprint_compat = false,
    update = function(self, card, dt)
        if G.playing_cards then
            for _, other in ipairs(G.playing_cards) do
                SMODS.debuff_card(other, other:is_face(true) and "prevent_debuff", "j_pencil_cell")
            end
        end
    end,
})

---@param card Card
---@return string[]
local function get_joker_desc(card)
    return localize({
        type = "raw_descriptions",
        set = "Joker",
        key = card.config.center_key,
        vars = card.config.center.loc_vars and card.config.center:loc_vars({}, card).vars or
            card:generate_UIBox_ability_table(true),
    })
end

SMODS.Joker({
    key = "peter",
    rarity = 1,
    config = { mult = 1 },
    loc_vars = function(self, info_queue, card)
        ---@type Card?
        local other = nil
        if G.jokers then
            for index, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    other = G.jokers.cards[index + 1]
                    break
                end
            end
        end
        return { vars = { card.ability.mult, other and #get_joker_desc(other) or 0 } }
    end,
    pos = { x = 1, y = 4 },
    atlas = "jokers",
    cost = 1,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            ---@type Card?
            local other = nil
            for index, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    other = G.jokers.cards[index + 1]
                    break
                end
            end
            if not other then
                return
            end
            ---@type table[]
            local messages = {}
            for _, line in ipairs(get_joker_desc(other)) do
                table.insert(messages,
                    {
                        mult = card.ability.mult,
                        remove_default_message = true,
                        message = line,
                        sound = 'multhit1',
                        colour = G.C.MULT,
                    })
            end
            return SMODS.merge_effects(messages)
        end
    end,
})
