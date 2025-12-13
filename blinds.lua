---Recalculate this blind's score
---@param self SMODS.Blind
local function recalculate_on_disable(self)
    StrangeLib.dynablind.update_blind_scores(StrangeLib.dynablind.find_blind(self.key))
end

SMODS.Blind {
    key = "glove",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 0 },
    atlas = "blinds",
    mult = 2,
    score = function(self, base)
        return base * (self.mult + (self.disabled and 0 or (0.1 * G.GAME.hands_played)))
    end,
    disable = recalculate_on_disable,
}

SMODS.Blind {
    key = "caret",
    boss = { min = 9 },
    in_pool = function()
        return G.GAME.round_resets.ante >= G.GAME.win_ante -- Boss should only appear in endless
    end,
    boss_colour = G.C.WHITE,
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
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 2 },
    atlas = "blinds",
    mult = 2,
}

local calculate_joker_hook = Card.calculate_joker
function Card:calculate_joker(context, ...)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and (context.repetition or context.retrigger_joker_check)) then
        return calculate_joker_hook(self, context, ...)
    elseif calculate_joker_hook(self, context, ...) then
        G.GAME.blind.triggered = true
    end
end

local calculate_seal_hook = Card.calculate_seal
function Card:calculate_seal(context, ...)
    if not (G.GAME.blind.name == "bl_pencil_arrow" and context.repetition) then
        return calculate_seal_hook(self, context, ...)
    elseif calculate_seal_hook(self, context, ...) then
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
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 3 },
    atlas = "blinds",
    mult = 2,
    press_play = function(self)
        ---@type Card[]
        local targets = {}
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.ability.pinned then
                table.insert(targets, joker)
            end
        end
        if #targets >= 1 then
            ---@type Card
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

---when set to `true`, means no cards will score
---@type Card | true?
local star_scoring_card = nil
SMODS.Blind {
    key = "star",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = HEX("000058"),
    pos = { x = 0, y = 4 },
    atlas = "blinds",
    mult = 2,
    debuff_hand = function(self, cards, hand, handname, check)
        star_scoring_card = nil
        return false
    end,
    calculate = function(self, blind, context)
        if context.modify_scoring_hand then
            if not star_scoring_card then
                if #context.scoring_hand ~= 1 then
                    blind.triggered = true
                end
                for _, card in ipairs(context.full_hand) do
                    if not SMODS.has_no_rank(card) and (not star_scoring_card or card.base.nominal > star_scoring_card.base.nominal or
                            (card.base.nominal == star_scoring_card.base.nominal and card.base.face_nominal > star_scoring_card.base.face_nominal)) then
                        star_scoring_card = card
                    end
                end
                star_scoring_card = star_scoring_card or true
            end
            return {
                add_to_hand = context.other_card == star_scoring_card,
                remove_from_hand = context.other_card ~= star_scoring_card,
            }
        end
    end
}

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
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 5 },
    atlas = "blinds",
    mult = 2,
    calculate = function(self, blind, context)
        if context.post_trigger and G.GAME.current_round.hands_played == 0 then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event { func = function()
                        context.other_card.ability.pencil_paralyzed = copy_table(SMODS.Stickers.pencil_paralyzed.config)
                        SMODS.debuff_card(context.other_card, true, "pencil_paralyzed")
                        SMODS.juice_up_blind()
                        return true
                    end })
                    blind.triggered = true
                    SMODS.calculate_effect(
                        { message = localize("k_paralyzed_ex"), colour = SMODS.Stickers.pencil_paralyzed.badge_colour },
                        context.other_card)
                end
            }
        end
    end
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

SMODS.Blind {
    key = "vessel",
    boss = { showdown = true },
    dollars = 8,
    boss_colour = G.P_BLINDS.bl_final_vessel.boss_colour,
    pos = { x = 0, y = 7 },
    atlas = "blinds",
    mult = 2,
    calculate = function(self, blind, context)
        if context.before or context.pre_discard then
            ---@type table<Card, true>
            local highlighted_set = StrangeLib.as_set(context.full_hand)
            ---@type Card[]
            local destroy = {}
            for _, card in ipairs(G.hand.cards) do
                if not highlighted_set[card] then
                    table.insert(destroy, card)
                end
            end
            SMODS.destroy_cards(destroy)
        end
    end
}

SMODS.Blind {
    key = "science",
    boss = { min = 1 },
    in_pool = function(self)
        if G.GAME.round_resets.ante < self.boss.min or not G.playing_cards then
            return false
        end
        for _, card in ipairs(G.playing_cards) do
            if card.base and card.base.suit and card:is_suit(card.base.suit) and SMODS.Suits[card.base.suit].strange then
                return true
            end
        end
        return false
    end,
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 9 },
    atlas = "blinds",
    mult = 2,
    recalc_debuff = function(self, card, from_blind)
        for key, suit in pairs(SMODS.Suits) do
            if suit.strange and card:is_suit(key, true) then
                return true
            end
        end
        return false
    end
}
