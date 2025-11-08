Balatest.TestPlay {
    name = "bl_arrow",
    category = { "blinds", "bl_arrow" },

    jokers = { "j_sock_and_buskin" },
    blind = "bl_pencil_arrow",

    execute = function()
        Balatest.play_hand({ "KC", "KS" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Pair.chips + 2 * SMODS.Ranks.King.nominal) * G.GAME.hands.Pair.mult)
    end
}

Balatest.TestPlay {
    name = "bl_lock",
    category = { "blinds", "bl_lock" },

    jokers = { "j_joker" },
    blind = "bl_pencil_lock",

    execute = function()
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert(G.jokers.cards[1].pinned)
    end
}

Balatest.TestPlay {
    name = "bl_star_straight",
    category = { "blinds", "bl_star" },

    blind = "bl_pencil_star",

    execute = function()
        Balatest.play_hand({ "AC", "KC", "QC", "JC", "10C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips + SMODS.Ranks.Ace.nominal) *
            G.GAME.hands["Straight Flush"].mult)
    end
}
Balatest.TestPlay {
    name = "bl_star_pair",
    category = { "blinds", "bl_star" },

    consumeables = { "c_heirophant", "c_empress" },
    blind = "bl_pencil_star",

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.highlight({ "AS" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AC", "AS" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Pair.chips + SMODS.Ranks.Ace.nominal + G.P_CENTERS.m_bonus.config.bonus) *
            G.GAME.hands.Pair.mult)
    end
}
Balatest.TestPlay {
    name = "bl_star_rearrange_pair",
    category = { "blinds", "bl_star" },

    consumeables = { "c_heirophant", "c_empress" },
    blind = "bl_pencil_star",

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.highlight({ "AS" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AS", "AC" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Pair.chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands.Pair.mult + G.P_CENTERS.m_mult.config.mult))
    end
}
Balatest.TestPlay {
    name = "bl_star_rocks",
    category = { "blinds", "bl_star" },

    consumeables = { "c_tower", "c_tower" },
    blind = "bl_pencil_star",

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.highlight({ "AS" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AC", "AS" })
    end,
    assert = function()
        Balatest.assert_chips(G.GAME.hands["High Card"].chips * G.GAME.hands["High Card"].mult)
    end
}
Balatest.TestPlay {
    name = "bl_star_face_nominal",
    category = { "blinds", "bl_star" },

    consumeables = { "c_heirophant", "c_empress" },
    blind = "bl_pencil_star",

    execute = function()
        Balatest.highlight({ "KC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.highlight({ "10S" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "10S", "KC" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.King.nominal + G.P_CENTERS.m_bonus.config.bonus) *
            G.GAME.hands["High Card"].mult)
    end
}

Balatest.TestPlay {
    name = "bl_fence_hit",
    category = { "blinds", "bl_fence" },

    jokers = { "j_joker" },
    blind = "bl_pencil_fence",

    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(orig, ...)
            return false
        end)
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert(G.jokers.cards[1].debuff)
    end
}
Balatest.TestPlay {
    name = "bl_fence_miss",
    category = { "blinds", "bl_fence" },

    jokers = { "j_jolly" },
    blind = "bl_pencil_fence",

    execute = function()
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert(not G.jokers.cards[1].paralyzed)
    end
}
