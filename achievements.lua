SMODS.Achievement {
    key = "hands",
    unlock_condition = function(self, args)
        if args.type == "hand" then
            for _, hand in pairs(G.GAME.hands) do
                if hand.played == 0 then
                    return
                end
            end
            return true
        end
    end
}
