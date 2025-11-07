---Recalculate this blind's score
---@param self SMODS.Blind
local function recalculate_on_disable(self)
    StrangeLib.dynablind.update_blind_scores(StrangeLib.dynablind.find_blind(self.key))
end

SMODS.Blind {
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
}

local play_hook = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e)
    play_hook(e)
    G.E_MANAGER:add_event(Event { trigger = 'immediate', func = function()
        G.E_MANAGER:add_event(Event { trigger = 'immediate', func = function()
            StrangeLib.dynablind.update_blind_scores(StrangeLib.dynablind.find_blind("bl_pencil_glove"))
            return true
        end })
        return true
    end })
end

SMODS.Blind {
    key = "caret",
    boss = { min = 9 },
    in_pool = function()
        return G.GAME.round_resets.ante >= G.GAME.win_ante -- Boss should only appear in endless
    end,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 1 },
    atlas = "blinds",
    mult = 1.5,
    score = function(self, base)
        return self.disabled and base or base ^ self.mult
    end,
    disable = recalculate_on_disable,
}

SMODS.Blind {
    key = "arrow",
    boss = { min = 4 },
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 2 },
    atlas = "blinds",
    mult = 2,
}

local calculate_joker_hook = Card.calculate_joker
function Card:calculate_joker(context)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and (context.repetition or context.retrigger_joker_check)) then
        local val = calculate_joker_hook(self, context)
        if val and G.GAME.blind.name == "bl_pencil_fence" and G.GAME.current_round.hands_played == 0 then
            return SMODS.merge_effects { val, {
                func = function()
                    G.E_MANAGER:add_event(Event { func = function()
                        self.ability.pencil_paralyzed = copy_table(SMODS.Stickers.pencil_paralyzed.config)
                        SMODS.debuff_card(self, true, "pencil_paralyzed")
                        G.GAME.blind.triggered = true
                        return true
                    end })
                    SMODS.calculate_effect(
                        { message = localize("k_paralyzed_ex"), colour = SMODS.Stickers.pencil_paralyzed.badge_colour },
                        self)
                end
            } }
        end
        return val
    elseif calculate_joker_hook(self, context) then
        G.GAME.blind.triggered = true
    end
end

local calculate_seal_hook = Card.calculate_seal
function Card:calculate_seal(context)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and context.repetition) then
        return calculate_seal_hook(self, context)
    elseif calculate_seal_hook(self, context) then
        G.GAME.blind.triggered = true
    end
end

SMODS.Blind {
    key = "lock",
    boss = { min = 3 },
    in_pool = function(self)
        if G.GAME.round_resets.ante < self.boss.min then
            return false
        end
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.pinned then
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
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.pinned then
                table.insert(targets, joker)
            end
        end
        if #targets >= 1 then
            local hit = pseudorandom_element(targets, pseudoseed(self.key))
            G.E_MANAGER:add_event(Event { trigger = "after", delay = 0.3, func = function()
                play_sound("gold_seal", 1.2, 0.4)
                hit:juice_up(0.3, 0.3)
                SMODS.Stickers.pinned:apply(hit, true)
                SMODS.juice_up_blind()
                return true
            end })
            G.GAME.blind.triggered = true
        end
    end,
}

SMODS.Blind {
    key = "star",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = HEX("000058"),
    pos = { x = 0, y = 4 },
    atlas = "blinds",
    mult = 2,
}

local poker_hand_info_hook = G.FUNCS.get_poker_hand_info
G.FUNCS.get_poker_hand_info = function(_cards)
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = poker_hand_info_hook(_cards)
    if next(poker_hands["High Card"]) and G.GAME.blind and G.GAME.blind.name == "bl_pencil_star" then
        local old_size = #scoring_hand
        scoring_hand = SMODS.has_no_rank(poker_hands["High Card"][1][1]) and {} or poker_hands["High Card"][1]
        if old_size ~= #scoring_hand then
            G.GAME.blind.triggered = true
        end
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

local always_scores_hook = SMODS.always_scores
function SMODS.always_scores(card)
    return not (G.GAME.blind and G.GAME.blind.name == "bl_pencil_star") and always_scores_hook(card)
end

SMODS.Blind {
    key = "fence",
    boss = { min = 2 },
    in_pool = function(self)
        if G.GAME.round_resets.ante < self.boss.min then
            return false
        end
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.pencil_paralyzed then
                return true
            end
        end
        return false
    end,
    boss_colour = HEX("FFFFFF"),
    pos = { x = 0, y = 5 },
    atlas = "blinds",
    mult = 2,
}

---Shared disable/defeat function for The Flower
---@param self SMODS.Blind
local function flower_disable(self)
    G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + G.GAME.current_round.hands_played
end

SMODS.Blind {
    key = "flower",
    boss = { min = 2 },
    in_pool = function(self)
        return G.GAME.round_resets.ante >= self.boss.min and
            G.hand.config.highlighted_limit >= G.GAME.round_resets.hands
    end,
    boss_colour = HEX("0080FF"),
    pos = { x = 0, y = 6 },
    atlas = "blinds",
    mult = 2,
    press_play = function(self)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1
    end,
    disable = flower_disable,
    defeat = flower_disable,
    drawn_to_hand = function(self)
        if G.hand.config.highlighted_limit < 1 then
            G.STATE = G.STATES.GAME_OVER
            if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
            end
            G:save_settings()
            G.FILE_HANDLER.force = true
            G.STATE_COMPLETE = false
        end
    end,
}
