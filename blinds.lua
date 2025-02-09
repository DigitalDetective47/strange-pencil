local function recalculate_on_disable(self)
    StrangeLib.dynablind.update_blind_scores(StrangeLib.dynablind.find_blind(self.key))
end

SMODS.Blind({
    key = "glove",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 0 },
    atlas = "blinds",
    mult = 2,
    increase = 0.1,
    score = function(self, base)
        return base * (self.mult + (self.disabled and 0 or (self.increase * G.GAME.hands_played)))
    end,
    disable = recalculate_on_disable,
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
    score = function(self, base)
        return self.disabled and base or base ^ self.mult
    end,
    disable = recalculate_on_disable,
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
    if G.GAME.blind and G.GAME.blind.name == "bl_pencil_star" then
        local old_size = #scoring_hand
        scoring_hand = SMODS.has_no_rank(poker_hands["High Card"][1][1]) and {} or poker_hands["High Card"][1]
        if old_size ~= #scoring_hand then
            G.GAME.blind.triggered = true
        end
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

local hook6 = SMODS.always_scores
function SMODS.always_scores(card)
    return not (G.GAME.blind and G.GAME.blind.name == "bl_pencil_star") and hook6(card)
end
