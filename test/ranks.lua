local function acquire_sneven()
    for _, card in ipairs(G.hand.cards) do
        if card.base.value == "2" and card:is_suit("Clubs") then
            StrangeLib.assert(SMODS.change_base(card, nil, "pencil_sneven"))
            G.hand:add_to_highlighted(card)
        end
    end
end

Balatest.TestPlay {
    name = "sneven_insert",
    category = { "ranks", "sneven" },

    execute = function()
        acquire_sneven()
        Balatest.play_hand({ "8C", "7C", "6C", "5C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips +
                SMODS.Ranks["8"].nominal +
                SMODS.Ranks.pencil_sneven.nominal +
                SMODS.Ranks["7"].nominal +
                SMODS.Ranks["6"].nominal +
                SMODS.Ranks["5"].nominal) *
            G.GAME.hands["Straight Flush"].mult)
    end
}
Balatest.TestPlay {
    name = "sneven_replace",
    category = { "ranks", "sneven" },

    execute = function()
        acquire_sneven()
        Balatest.play_hand({ "8C", "6C", "5C", "4C" })
    end,
    assert = function()
        Balatest.assert_chips((G.GAME.hands["Straight Flush"].chips +
                SMODS.Ranks["8"].nominal +
                SMODS.Ranks.pencil_sneven.nominal +
                SMODS.Ranks["6"].nominal +
                SMODS.Ranks["5"].nominal +
                SMODS.Ranks["4"].nominal) *
            G.GAME.hands["Straight Flush"].mult)
    end
}
