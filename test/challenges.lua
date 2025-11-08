Balatest.TestPlay {
    name = "c_permamouth",
    category = { "challenges", "c_permamouth" },

    custom_rules = { { id = "pencil_most_played_only" } },

    execute = function()
        Balatest.play_hand({ "AC", "AS" })
        Balatest.next_round()
        Balatest.play_hand({ "AC" })
        Balatest.play_hand({ "AS" })
    end,
    assert = function()
        Balatest.assert_chips(0)
    end
}
