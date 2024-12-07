SMODS.Atlas({
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95,
})

SMODS.Back({
    key = "royal",
    order = 3,
    config = { hand_size = -4 },
    -- loc_vars = function(self, info_queue, center)
    --     return {
    --         vars = {
    --             center.effect.config.hand_size < 0 and center.effect.config.hand_size or "+" .. center.effect.config.hand_size,
    --         },
    --     }
    -- end,
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
