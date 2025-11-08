Balatest.TestPlay {
    name = "c_negative_space_default",
    category = { "consumables", "spectrals", "c_negative_space" },

    consumeables = { "c_pencil_negative_space" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 5)
        for _, joker in ipairs(G.jokers.cards) do
            Balatest.assert(joker.edition.negative)
            Balatest.assert(SMODS.is_eternal(joker))
        end
    end
}
Balatest.TestPlay {
    name = "c_negative_space_black",
    category = { "consumables", "spectrals", "c_negative_space" },

    back = "Black Deck",
    consumeables = { "c_pencil_negative_space" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 6)
        for _, joker in ipairs(G.jokers.cards) do
            Balatest.assert(joker.edition.negative)
            Balatest.assert(SMODS.is_eternal(joker))
        end
    end
}
Balatest.TestPlay {
    name = "c_negative_space_double",
    category = { "consumables", "spectrals", "c_negative_space" },

    consumeables = { "c_pencil_negative_space", "c_pencil_negative_space" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
        Balatest.use(G.consumeables.cards[2])
    end,
    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 5 + 10)
        for _, joker in ipairs(G.jokers.cards) do
            Balatest.assert(joker.edition.negative)
            Balatest.assert(SMODS.is_eternal(joker))
        end
    end
}

Balatest.TestPlay {
    name = "c_pulsar",
    category = { "consumables", "spectrals", "c_pulsar" },

    consumeables = { "c_pluto", "c_pluto", "c_pencil_pulsar" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AC" })
        Balatest.use(G.consumeables.cards[3])
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.hands["High Card"].level, 3 * 2)
    end
}
