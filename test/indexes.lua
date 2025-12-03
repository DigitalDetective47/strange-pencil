local function empty() end
local function not_usable()
    Balatest.assert(not G.consumeables.cards[1]:can_use_consumeable())
end
local function use_first()
    Balatest.use(G.consumeables.cards[1])
end

Balatest.TestPlay {
    name = "c_replica_no_selection",
    category = { "consumables", "indexes", "c_replica" },

    consumeables = { "c_pencil_replica" },

    execute = empty,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_replica_multiple_selection",
    category = { "consumables", "indexes", "c_replica" },

    consumeables = { "c_pencil_replica", "c_emperor", "c_emperor" },

    execute = function()
        G.consumeables:add_to_highlighted(G.consumeables.cards[2])
        G.consumeables:add_to_highlighted(G.consumeables.cards[3])
    end,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_replica_use",
    category = { "consumables", "indexes", "c_replica" },

    consumeables = { "c_pencil_replica", "c_emperor" },

    execute = function()
        G.consumeables:add_to_highlighted(G.consumeables.cards[2])
        use_first()
    end,
    assert = function()
        Balatest.assert_eq(#SMODS.find_card("c_emperor"), 2)
    end
}

Balatest.TestPlay {
    name = "c_counterfeit",
    category = { "consumables", "indexes", "c_counterfeit" },

    consumeables = { "c_pencil_counterfeit" },

    execute = use_first,
    assert = function()
        Balatest.assert_dollars(SMODS.Centers.c_pencil_counterfeit.config.dollars)
    end
}

Balatest.TestPlay {
    name = "c_chisel_no_selection",
    category = { "consumables", "indexes", "c_chisel" },

    consumeables = { "c_pencil_chisel" },

    execute = empty,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_chisel_no_stickers",
    category = { "consumables", "indexes", "c_chisel" },

    jokers = { "j_joker" },
    consumeables = { "c_pencil_chisel" },

    execute = function()
        G.jokers:add_to_highlighted(G.jokers.cards[1])
    end,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_chisel_use",
    category = { "consumables", "indexes", "c_chisel" },

    jokers = { { id = "j_joker", eternal = true } },
    consumeables = { "c_pencil_chisel" },

    execute = function()
        G.jokers:add_to_highlighted(G.jokers.cards[1])
        use_first()
    end,
    assert = function()
        assert(not SMODS.is_eternal(G.jokers.cards[1]))
    end
}

Balatest.TestPlay {
    name = "c_peek_no_targets",
    category = { "consumables", "indexes", "c_peek" },

    consumeables = { "c_pencil_peek" },

    execute = empty,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_peek_use",
    category = { "consumables", "indexes", "c_peek" },

    consumeables = { "c_pencil_peek" },
    blind = "bl_wheel",
    no_auto_start = true,

    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(orig, ...)
            return true
        end)
        Balatest.start_round()
        use_first()
    end,
    assert = function()
        for _, card in ipairs(G.hand.cards) do
            Balatest.assert_eq(card.facing, "front")
        end
    end
}

Balatest.TestPlay {
    name = "c_mixnmatch_one_selected",
    category = { "consumables", "indexes", "c_mixnmatch" },

    consumeables = { "c_pencil_mixnmatch" },

    execute = function()
        Balatest.highlight({ "AC" })
    end,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_mixnmatch_three_selected",
    category = { "consumables", "indexes", "c_mixnmatch" },

    consumeables = { "c_pencil_mixnmatch" },

    execute = function()
        Balatest.highlight({ "AC", "AS", "AH" })
    end,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_mixnmatch_use",
    category = { "consumables", "indexes", "c_mixnmatch" },

    consumeables = { "c_heirophant", "c_pencil_mixnmatch" },

    execute = function()
        Balatest.highlight({ "AS" })
        use_first()
        Balatest.highlight({ "AC", "AS" })
        Balatest.use(G.consumeables.cards[2])
    end,
    assert = function()
        for _, card in ipairs(G.hand.cards) do
            if card.base.value == "Ace" and card:is_suit("Clubs") then
                Balatest.assert(SMODS.has_enhancement(card, "m_bonus"))
            end
        end
    end
}

Balatest.TestPlay {
    name = "c_fractal",
    category = { "consumables", "indexes", "c_fractal" },

    consumeables = { "c_pencil_fractal" },

    execute = use_first,
    assert = function()
        Balatest.assert_eq(#G.consumeables.cards, SMODS.Centers.c_pencil_fractal.config.cards)
    end
}

Balatest.TestPlay {
    name = "c_ono99_notfull",
    category = { "consumables", "indexes", "c_ono99" },

    consumeables = { "c_pencil_ono99" },

    execute = empty,
    assert = not_usable
}
Balatest.TestPlay {
    name = "c_ono99_use",
    category = { "consumables", "indexes", "c_ono99" },

    consumeables = { "c_pencil_ono99", "c_pencil_ono99" },

    execute = use_first,
    assert = function()
        Balatest.assert_neq(#G.consumeables.cards, 0)
        Balatest.assert_eq(#SMODS.find_card("c_pencil_ono99"), 0)
    end
}
Balatest.TestPlay {
    name = "c_ono99_preserve_edition",
    category = { "consumables", "indexes", "c_ono99" },

    consumeables = { "c_pencil_ono99", "c_pencil_ono99" },

    execute = function()
        G.consumeables.cards[2]:set_edition("e_foil")
        use_first()
    end,
    assert = function()
        Balatest.assert_eq(#SMODS.find_card("c_pencil_ono99"), 0)
        Balatest.assert(G.consumeables.cards[1].edition.foil)
    end
}
