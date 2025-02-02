-- Dynamic blind scaling system
local hook = Game.update
function Game:update(dt)
    for k, v in ipairs({ "Small", "Big", "Boss" }) do
        if
            G.GAME
            and G.GAME.round_resets
            and G.GAME.round_resets.blind_choices
            and G.GAME.round_resets.blind_choices[v]
            and G.P_BLINDS[G.GAME.round_resets.blind_choices[v]].get_mult
            and G.GAME.round_resets.blind_states[v] == "Current" and not G.GAME.blind.disabled then
            if G.GAME.blind.ante == nil then -- Prevents score from changing unexpectedly when boss is defeated
                G.GAME.blind.ante = G.GAME.round_resets.ante
            end
            G.GAME.blind.chips = (get_blind_amount(G.GAME.blind.ante) * G.GAME.starting_params.ante_scaling) ^
                G.GAME.starting_params.ante_scaling_exponential *
                G.P_BLINDS[G.GAME.round_resets.blind_choices[v]]:get_mult()
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
    return hook(self, dt)
end

local hook2 = Game.update_shop
function Game:update_shop(dt)
    G.GAME.blind.ante = nil
    return hook2(self, dt)
end

SMODS.Blind({
    key = "glove",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 0 },
    atlas = "blinds",
    get_mult = function(self)
        return 2 + 0.1 * G.GAME.hands_played
    end,
    disable = function(self)
        G.GAME.blind.chips = 2 *
            get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
})

SMODS.Blind({
    key = "caret",
    boss = { min = 9 },
    in_pool = function()
        return G.GAME.round_resets.ante >= G.GAME.win_ante -- Boss should only appear in endless
            or G.GAME.modifiers.endless_scaling            -- or if endless scaling is enabled
    end,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 1 },
    atlas = "blinds",
    mult = 1.5,
    get_mult = function(self)
        return (get_blind_amount(G.GAME.blind.ante == nil and G.GAME.round_resets.ante or G.GAME.blind.ante) * G.GAME.starting_params.ante_scaling) ^
            (G.GAME.starting_params.ante_scaling_exponential * (self.mult - 1))
    end,
    disable = function(self)
        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
})

SMODS.Blind({
    key = "arrow",
    boss = { min = 4 },
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 2 },
    atlas = "blinds",
    mult = 2,
})

local hook3 = Card.calculate_joker
function Card:calculate_joker(context)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and (context.repetition or context.retrigger_joker_check)) then
        return hook3(self, context)
    elseif hook3(self, context) then
        G.GAME.blind.triggered = true
    end
end

local hook4 = Card.calculate_seal
function Card:calculate_seal(context)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and context.repetition) then
        return hook4(self, context)
    elseif hook4(self, context) then
        G.GAME.blind.triggered = true
    end
end

SMODS.Blind({
    key = "lock",
    boss = { min = 3 },
    in_pool = function(self)
        if G.GAME.round_resets.ante < 3 then
            return false
        end
        for k, v in ipairs(G.jokers.cards) do
            if not v.ability.pinned then
                return true
            end
        end
        return false
    end,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 3 },
    atlas = "blinds",
    mult = 2,
    press_play = function(self)
        local targets = {}
        for k, v in ipairs(G.jokers.cards) do
            if not v.ability.pinned then
                table.insert(targets, v)
            end
        end
        if #targets >= 1 then
            local hit = pseudorandom_element(targets, pseudoseed(self.key))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.3,
                func = function()
                    play_sound("gold_seal", 1.2, 0.4)
                    hit:juice_up(0.3, 0.3)
                    SMODS.Stickers.pinned:apply(hit, true)
                    SMODS.juice_up_blind()
                    return true
                end
            }))
            G.GAME.blind.triggered = true
        end
    end,
})

SMODS.Blind({
    key = "star",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = HEX("000058"),
    pos = { x = 0, y = 4 },
    atlas = "blinds",
    mult = 2,
})

local hook5 = G.FUNCS.get_poker_hand_info
G.FUNCS.get_poker_hand_info = function(_cards)
    local text
    local loc_disp_text
    local poker_hands
    local scoring_hand
    local disp_text
    text, loc_disp_text, poker_hands, scoring_hand, disp_text = hook5(_cards)
    if G.GAME.blind.name == "bl_pencil_star" then
        scoring_hand = SMODS.has_no_rank(poker_hands["High Card"][1][1]) and {} or poker_hands["High Card"][1]
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

local hook6 = SMODS.always_scores
function SMODS.always_scores(card)
    return not (G.GAME.blind and G.GAME.blind.name == "bl_pencil_star") and hook6(card)
end
