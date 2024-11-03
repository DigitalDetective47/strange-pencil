SMODS.Atlas({
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95,
})

SMODS.Back({
    key = "royal",
    order = 3,
    config = { hand_size = -4, pencil_only_faces = true },
    -- loc_vars = function(self, info_queue, center)
    --     return {
    --         vars = {
    --             center.effect.config.hand_size < 0 and center.effect.config.hand_size or "+" .. center.effect.config.hand_size,
    --         },
    --     }
    -- end,
    pos = { x = 0, y = 0 },
    atlas = "decks",
})
