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
        if args then
            if args.initial_deck then
                return false
            elseif args.suit ~= "" then
                return true
            end
        end
        for _, card in ipairs(G.playing_cards or {}) do
            if card.base.value == "pencil_sneven" then
                return true
            end
        end
        return false
    end,
    suit_map = {
        Hearts = 0,
        Clubs = 1,
        Diamonds = 2,
        Spades = 3,
        mtg_Clovers = 4,
        minty_3s = 5,
        six_Stars = 6,
        six_Moons = 7,
        bunc_Fleurons = 8,
        bunc_Halberds = 9,
    },
})

table.insert(SMODS.Ranks["6"].next, "pencil_sneven")
table.insert(SMODS.Ranks["7"].next, "pencil_sneven")
