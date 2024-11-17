SMODS.Atlas({
    key = "blinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 1,
})

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
