Balatest.TestPlay {
    name = "v_half_chip",
    category = { "vouchers", "v_half_chip" },

    vouchers = { "v_pencil_half_chip" },

    execute = function() end,
    assert = function()
        Balatest.assert_eq(G.GAME.blind.chips, 150)
    end
}
