local function default_exexute()
    Balatest.play_hand({ "AC" })
end
local function default_assert()
    Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) * G.GAME.hands["High Card"].mult)
end

Balatest.TestPlay {
    name = "j_swimmers_no_enhancements",
    category = { "jokers", "j_swimmers" },

    jokers = { "j_pencil_swimmers" },

    execute = default_exexute,
    assert = default_assert
}
Balatest.TestPlay {
    name = "j_swimmers_partial",
    category = { "jokers", "j_swimmers" },

    jokers = { "j_pencil_swimmers" },
    consumeables = { "c_heirophant" },

    execute = function()
        Balatest.highlight({ "AC", "AS" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.play_hand({ "AC", "AS", "AH" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Three of a Kind"].chips + 3 * SMODS.Ranks.Ace.nominal + 2 * G.P_CENTERS.m_bonus.config.bonus) *
            G.GAME.hands["Three of a Kind"].mult)
    end
}
Balatest.TestPlay {
    name = "j_swimmers_mismatch",
    category = { "jokers", "j_swimmers" },

    jokers = { "j_pencil_swimmers" },
    consumeables = { "c_heirophant", "c_empress" },

    execute = function()
        Balatest.highlight({ "AC", "AS" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.highlight({ "AH", "AD" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AC", "AS", "AH", "AD" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Four of a Kind"].chips + 4 * SMODS.Ranks.Ace.nominal + 2 * G.P_CENTERS.m_bonus.config.bonus) *
            (G.GAME.hands["Four of a Kind"].mult + 2 * G.P_CENTERS.m_mult.config.mult))
    end
}
Balatest.TestPlay {
    name = "j_swimmers_success",
    category = { "jokers", "j_swimmers" },

    jokers = { "j_pencil_swimmers" },
    consumeables = { "c_heirophant" },

    execute = function()
        Balatest.highlight({ "AC", "AS" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.play_hand({ "AC", "AS" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Pair.chips + 2 * SMODS.Ranks.Ace.nominal + 2 * G.P_CENTERS.m_bonus.config.bonus) *
            (G.GAME.hands.Pair.mult + 2 * SMODS.Centers.j_pencil_swimmers.config.mult))
    end
}

Balatest.TestPlay {
    name = "j_lass_xmult",
    category = { "jokers", "j_lass" },

    jokers = { "j_pencil_lass" },
    consumeables = { "c_cryptid" },

    execute = function()
        Balatest.highlight({ "QC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult * (3 * SMODS.Centers.j_pencil_lass.config.xmult_per_queen)))
    end
}
Balatest.TestPlay {
    name = "j_lass_pool",
    category = { "jokers", "j_lass" },

    execute = function()
    end,
    assert = function()
        Balatest.assert(not SMODS.Centers.j_pencil_lass:in_pool({}))
    end
}

Balatest.TestPlay {
    name = "exodia",
    category = { "jokers", "j_forbidden_one", "j_left_arm", "j_left_leg", "j_right_arm", "j_right_leg" },

    jokers = { "j_pencil_forbidden_one", "j_pencil_left_arm", "j_pencil_left_leg", "j_pencil_right_arm" },

    execute = function()
        Balatest.hook(_G, "create_card", function(orig, t, a, l, r, k, s, forced_key, ...)
            return orig(t, a, l, r, k, s, "j_pencil_right_leg", ...)
        end)
        Balatest.cash_out()
        Balatest.hook(_G, "win_game", function(orig) end)
        Balatest.buy(function() return G.shop_jokers.cards[1] end)
    end,
    assert = function()
        Balatest.assert(G.GAME.won)
    end
}
Balatest.TestPlay {
    name = "j_forbidden_one",
    category = { "jokers", "j_forbidden_one" },

    jokers = { "j_pencil_forbidden_one" },

    execute = function()
        Balatest.next_round()
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.dollars, SMODS.Centers.j_pencil_forbidden_one.config.payout)
    end
}
Balatest.TestPlay {
    name = "j_left_arm",
    category = { "jokers", "j_left_arm" },

    jokers = { "j_pencil_left_arm" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips(((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) * SMODS.Centers.j_pencil_left_arm.config.xchips) *
            G.GAME.hands["High Card"].mult)
    end
}
Balatest.TestPlay {
    name = "j_left_leg",
    category = { "jokers", "j_left_leg" },

    jokers = { "j_pencil_left_leg" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal + SMODS.Centers.j_pencil_left_leg.config.chips) *
            G.GAME.hands["High Card"].mult)
    end
}
Balatest.TestPlay {
    name = "j_right_arm",
    category = { "jokers", "j_right_arm" },

    jokers = { "j_pencil_right_arm" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult * SMODS.Centers.j_pencil_right_arm.config.xmult))
    end
}
Balatest.TestPlay {
    name = "j_right_leg",
    category = { "jokers", "j_right_leg" },

    jokers = { "j_pencil_right_leg" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult + SMODS.Centers.j_pencil_right_leg.config.mult))
    end
}

Balatest.TestPlay {
    name = "j_doodlebob",
    category = { "jokers", "j_doodlebob" },

    jokers = { "j_pencil_doodlebob" },
    consumeables = { "c_pencil_counterfeit" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal + SMODS.Centers.j_pencil_doodlebob.config.chips_per_index) *
            G.GAME.hands["High Card"].mult)
    end
}

Balatest.TestPlay {
    name = "j_pencil_tarot",
    category = { "jokers", "j_pencil" },

    jokers = { "j_pencil_pencil" },
    consumeables = { "c_temperance" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(#G.consumeables.cards, 1)
    end
}
Balatest.TestPlay {
    name = "j_pencil_index",
    category = { "jokers", "j_pencil" },

    jokers = { "j_pencil_pencil" },
    consumeables = { "c_pencil_counterfeit" },

    execute = function()
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(#G.consumeables.cards, 0)
    end
}

Balatest.TestPlay {
    name = "j_forty_seven_whiff",
    category = { "jokers", "j_forty_seven" },

    jokers = { "j_pencil_forty_seven" },

    execute = default_exexute,
    assert = default_assert
}
Balatest.TestPlay {
    name = "j_forty_seven_discard",
    category = { "jokers", "j_forty_seven" },

    jokers = { "j_pencil_forty_seven" },

    execute = function()
        Balatest.discard({ "7C", "7S", "7H", "7D" })
        Balatest.play_hand({ "4C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks["4"].nominal) *
            G.GAME.hands["High Card"].mult)
    end
}
Balatest.TestPlay {
    name = "j_forty_seven_hit",
    category = { "jokers", "j_forty_seven" },

    jokers = { "j_pencil_forty_seven" },

    execute = function()
        Balatest.play_hand({ "4C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + 5 * SMODS.Ranks["4"].nominal) *
            G.GAME.hands["High Card"].mult)
    end
}

Balatest.TestPlay {
    name = "j_square",
    category = { "jokers", "j_square" },

    jokers = { "j_pencil_square" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips(((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) ^ SMODS.Centers.j_pencil_square.config.exponent) *
            G.GAME.hands["High Card"].mult)
    end
}

Balatest.TestPlay {
    name = "j_pee_pants_diamonds",
    category = { "jokers", "j_pee_pants" },

    jokers = { "j_pencil_pee_pants" },

    execute = function()
        Balatest.play_hand({ "AD", "KD", "QD", "JD", "9D" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Flush.chips +
                SMODS.Ranks.Ace.nominal +
                SMODS.Ranks.King.nominal +
                SMODS.Ranks.Queen.nominal +
                SMODS.Ranks.Jack.nominal +
                SMODS.Ranks["9"].nominal) *
            G.GAME.hands.Flush.mult)
    end
}
Balatest.TestPlay {
    name = "j_pee_pants_two_pair",
    category = { "jokers", "j_pee_pants" },

    jokers = { "j_pencil_pee_pants" },

    execute = function()
        Balatest.play_hand({ "AC", "AD", "QC", "QS" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Two Pair"].chips + 2 * SMODS.Ranks.Ace.nominal + 2 * SMODS.Ranks.Queen.nominal) *
            G.GAME.hands["Two Pair"].mult)
    end
}
Balatest.TestPlay {
    name = "j_pee_pants_hit",
    category = { "jokers", "j_pee_pants" },

    jokers = { "j_pencil_pee_pants" },

    execute = function()
        Balatest.play_hand({ "AC", "AD", "QC", "QD" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Two Pair"].chips + 2 * SMODS.Ranks.Ace.nominal + 2 * SMODS.Ranks.Queen.nominal) *
            (G.GAME.hands["Two Pair"].mult + SMODS.Centers.j_pencil_pee_pants.config.scaling))
    end
}

Balatest.TestPlay {
    name = "j_squeeze_crack",
    category = { "jokers", "j_squeeze" },

    jokers = { "j_pencil_squeeze" },

    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(orig, ...)
            return true
        end)
        Balatest.end_round()
    end,
    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 0)
    end
}
Balatest.TestPlay {
    name = "j_squeeze_upgrade",
    category = { "jokers", "j_squeeze" },

    jokers = { "j_pencil_squeeze" },

    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(orig, ...)
            return false
        end)
        Balatest.next_round()
        Balatest.end_round()
    end,
    assert = function()
        Balatest.assert_eq(G.jokers.cards[1].ability.extra_value, 1 + 2)
    end
}

Balatest.TestPlay {
    name = "j_eclipse_basic",
    category = { "jokers", "j_eclipse" },

    jokers = { "j_pencil_eclipse", "j_splash" },

    execute = function()
        Balatest.play_hand({ "AC", "KC", "AH", "QC", "QH" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Two Pair"].chips + 2 * SMODS.Ranks.Ace.nominal + SMODS.Ranks.King.nominal + 2 * SMODS.Ranks.Queen.nominal) *
            (G.GAME.hands["Two Pair"].mult + 3 * SMODS.Centers.j_pencil_eclipse.config.gain - 2 * SMODS.Centers.j_pencil_eclipse.config.loss))
    end
}
Balatest.TestPlay {
    name = "j_eclipse_floor",
    category = { "jokers", "j_eclipse" },

    jokers = { "j_pencil_eclipse" },

    execute = function()
        Balatest.play_hand({ "AH", "QH", "AC", "QC" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Two Pair"].chips + 2 * SMODS.Ranks.Ace.nominal + 2 * SMODS.Ranks.Queen.nominal) *
            (G.GAME.hands["Two Pair"].mult + 2 * SMODS.Centers.j_pencil_eclipse.config.gain))
    end
}

Balatest.TestPlay {
    name = "j_club_die",
    category = { "jokers", "j_club" },

    jokers = { "j_pencil_club" },

    execute = function()
        Balatest.play_hand({ "AH" })
    end,
    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 0)
    end
}

Balatest.TestPlay {
    name = "j_club_retrigger",
    category = { "jokers", "j_club" },

    jokers = { "j_pencil_club" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips(math.floor((G.GAME.hands["High Card"].chips + (SMODS.Centers.j_pencil_club.config.retriggers + 1) * SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult * SMODS.Centers.j_pencil_club.config.xmult ^ (SMODS.Centers.j_pencil_club.config.retriggers + 1))))
    end
}

Balatest.TestPlay {
    name = "j_calendar",
    category = { "jokers", "j_calendar" },

    jokers = { "j_pencil_calendar" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal + SMODS.Centers.j_pencil_calendar.config.day) *
            (G.GAME.hands["High Card"].mult + SMODS.Centers.j_pencil_calendar.config.month))
    end
}

Balatest.TestPlay {
    name = "j_doot_diseased",
    category = { "jokers", "j_doot" },

    jokers = { "j_pencil_doot" },
    consumeables = { "c_pencil_plague" },

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.dollars, 0)
    end
}
Balatest.TestPlay {
    name = "j_doot_flagged",
    category = { "jokers", "j_doot" },

    jokers = { "j_pencil_doot" },
    consumeables = { "c_pencil_parade" },

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.dollars, 0)
    end
}
Balatest.TestPlay {
    name = "j_doot_hit",
    category = { "jokers", "j_doot" },

    jokers = { "j_pencil_doot" },
    consumeables = { "c_pencil_plague", "c_pencil_parade" },

    execute = function()
        Balatest.highlight({ "AC" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.highlight({ "AS" })
        Balatest.use(G.consumeables.cards[2])
        Balatest.play_hand({ "AC", "AH", "AS" })
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.dollars, SMODS.Centers.j_pencil_doot.config.dollars)
    end
}

Balatest.TestPlay {
    name = "j_ratio_tie",
    category = { "jokers", "j_ratio" },

    jokers = { "j_pencil_ratio" },

    execute = default_exexute,
    assert = default_assert
}
Balatest.TestPlay {
    name = "j_ratio_upgrade",
    category = { "jokers", "j_ratio" },

    jokers = { "j_pencil_ratio" },
    consumeables = { "c_world" },

    execute = function()
        Balatest.highlight({ "AH", "AD" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.play_hand({ "AC" })
    end,
    assert = function()
        Balatest.assert_chips(math.floor((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult * (1 + 15 / 52))))
    end
}
Balatest.TestPlay {
    name = "j_ratio_reset",
    category = { "jokers", "j_ratio" },

    jokers = { "j_pencil_ratio" },
    consumeables = { "c_world" },

    execute = function()
        Balatest.highlight({ "AH", "AD" })
        Balatest.use(G.consumeables.cards[1])
        Balatest.unhighlight_all()
        Balatest.play_hand({ "AC", "KC", "QC", "JS", "10C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands.Straight.chips +
                SMODS.Ranks.Ace.nominal +
                SMODS.Ranks.King.nominal +
                SMODS.Ranks.Queen.nominal +
                SMODS.Ranks.Jack.nominal +
                SMODS.Ranks["10"].nominal) *
            G.GAME.hands.Straight.mult)
    end
}

Balatest.TestPlay {
    name = "j_commie",
    category = { "jokers", "j_commie" },

    jokers = { "j_pencil_commie" },

    execute = function()
        Balatest.play_hand({ "AC", "KC", "QC", "JC", "10C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips + 5 * SMODS.Ranks["10"].nominal) *
            G.GAME.hands["Straight Flush"].mult)
        ---@type integer
        local aces = 0
        for _, card in ipairs(G.playing_cards) do
            if card.base.value == "Ace" then
                aces = aces + 1
            end
        end
        Balatest.assert_eq(aces, 4 - 1)
    end
}

Balatest.TestPlay {
    name = "j_night_club_whiff",
    category = { "jokers", "j_night_club" },

    jokers = { "j_pencil_night_club" },

    execute = function()
        Balatest.play_hand({ "AS", "KS", "QS", "JS", "10S" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips +
                SMODS.Ranks.Ace.nominal +
                SMODS.Ranks.King.nominal +
                SMODS.Ranks.Queen.nominal +
                SMODS.Ranks.Jack.nominal +
                SMODS.Ranks["10"].nominal) *
            G.GAME.hands["Straight Flush"].mult)
        ---@type integer
        local clubs = 0
        for _, card in ipairs(G.playing_cards) do
            if card:is_suit("Clubs") then
                clubs = clubs + 1
            end
        end
        Balatest.assert_eq(clubs, 13)
    end
}
Balatest.TestPlay {
    name = "j_night_club_hit",
    category = { "jokers", "j_night_club" },

    jokers = { "j_pencil_night_club" },
    hands = 1,

    execute = function()
        Balatest.play_hand({ "AS", "KS", "QS", "JS", "10S" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips +
                SMODS.Ranks.Ace.nominal +
                SMODS.Ranks.King.nominal +
                SMODS.Ranks.Queen.nominal +
                SMODS.Ranks.Jack.nominal +
                SMODS.Ranks["10"].nominal) *
            G.GAME.hands["Straight Flush"].mult)
        ---@type integer
        local clubs = 0
        for _, card in ipairs(G.playing_cards) do
            if card:is_suit("Clubs") then
                clubs = clubs + 1
            end
        end
        Balatest.assert_eq(clubs, 13 + 5)
    end
}

Balatest.TestPlay {
    name = "j_fizzler",
    category = { "jokers", "j_fizzler" },

    jokers = { "j_pencil_fizzler" },
    consumeables = { "c_emperor", "c_pencil_counterfeit" },

    execute = default_exexute,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["High Card"].chips + SMODS.Ranks.Ace.nominal) *
            (G.GAME.hands["High Card"].mult + math.floor(G.P_CENTERS.c_emperor.cost / 2) + math.floor(SMODS.Centers.c_pencil_counterfeit.cost / 2)))
    end
}
