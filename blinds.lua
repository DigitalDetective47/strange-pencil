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
        return (get_blind_amount(G.GAME.blind.ante == nil and G.GAME.round_resets.ante or G.GAME.blind.ante) * G.GAME.starting_params.ante_scaling) ^ (G.GAME.starting_params.ante_scaling_exponential * (self.mult - 1))
    end,
    disable = function(self)
        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
})
