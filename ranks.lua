SMODS.Atlas({
    key = "ranks",
    path = "ranks.png",
    px = 71,
    py = 95,
})
SMODS.Atlas({
    key = "hc_ranks",
    path = "hc_ranks.png",
    px = 71,
    py = 95,
})

SMODS.Rank({
    key = "sneven",
    card_key = "7~",
    pos = { x = 0 },
    nominal = 7,
    lc_atlas = "ranks",
    hc_atlas = "hc_ranks",
    shorthand = "7~",
    face_nominal = 0.01,
    next = { "8" },
    in_pool = function(self, args)
        return not args.initial_deck
    end,
})

table.insert(SMODS.Ranks["6"].next, "pencil_sneven")
