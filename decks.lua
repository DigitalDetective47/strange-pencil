SMODS.Atlas({
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95,
})

SMODS.Back({
    key = "royal",
    config = { hand_size = -4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.hand_size } }
    end,
    pos = { x = 0, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if not card:is_face() then
                        card:remove()
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end
})

function Gaussian(mean, variance)
    return math.sqrt(-2 * variance * math.log(pseudorandom('normal_deck'))) *
        math.cos(2 * math.pi * pseudorandom('normal_deck')) + mean
end

SMODS.Back({
    key = "normal",
    config = { mean = 8, variance = 9 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.mean, math.sqrt(self.config.variance) } }
    end,
    pos = { x = 1, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    local rank_suffix
                    repeat
                        rank_suffix = math.floor(Gaussian(self.config.mean, self.config.variance) + 0.5)
                    until rank_suffix >= 2 and rank_suffix <= 14
                    if rank_suffix < 10 then
                        rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then
                        rank_suffix = 'T'
                    elseif rank_suffix == 11 then
                        rank_suffix = 'J'
                    elseif rank_suffix == 12 then
                        rank_suffix = 'Q'
                    elseif rank_suffix == 13 then
                        rank_suffix = 'K'
                    elseif rank_suffix == 14 then
                        rank_suffix = 'A'
                    end
                    v:set_base(G.P_CARDS[string.sub(v.base.suit, 1, 1) .. '_' .. rank_suffix])
                end
                return true
            end
        }))
    end
})

SMODS.Back({
    key = "rainbow",
    pos = { x = 2, y = 0 },
    atlas = "decks",
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                for r = 2, 14, 1 do
                    local rank_suffix
                    if r < 10 then
                        rank_suffix = tostring(r)
                    elseif r == 10 then
                        rank_suffix = 'T'
                    elseif r == 11 then
                        rank_suffix = 'J'
                    elseif r == 12 then
                        rank_suffix = 'Q'
                    elseif r == 13 then
                        rank_suffix = 'K'
                    elseif r == 14 then
                        rank_suffix = 'A'
                    end
                    local suit = pseudorandom_element({ "S", "H", "C", "D" }, pseudoseed('rainbow_deck'))
                    for k, v in ipairs(G.playing_cards) do
                        if v.base.id == r then
                            v:set_base(G.P_CARDS[suit .. '_' .. rank_suffix])
                        end
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end
})
