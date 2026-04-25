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

SMODS.Achievement {
    key = "negative_stake",
    unlock_condition = function(self, args)
        if args.type == "win" then
            for _, stake in ipairs(G.GAME.applied_stakes) do
                if stake == "stake_pencil_negative" then
                    return true
                end
            end
        end
    end
}
