SMODS.current_mod.optional_features = { cardareas = { discard = true, deck = true } }

SMODS.load_file("atlas.lua")()
SMODS.load_file("blinds.lua")()
SMODS.load_file("boosters.lua")()
SMODS.load_file("challenges.lua")()
SMODS.load_file("decks.lua")()
SMODS.load_file("enhancements.lua")()
SMODS.load_file("indexes.lua")()
SMODS.load_file("jokers.lua")()
SMODS.load_file("ranks.lua")()
SMODS.load_file("spectrals.lua")()
SMODS.load_file("stakes.lua")()
SMODS.load_file("stickers.lua")()
SMODS.load_file("tags.lua")()
SMODS.load_file("vouchers.lua")()

for challenge_key, restrictions in pairs(SMODS.load_file("challenge_restrictions.lua")()) do
    if SMODS.Challenges[challenge_key] then -- allows overriding modded challenges without crashing if that mod isn't installed
        if restrictions.banned_cards then
            for i, item in pairs(restrictions.banned_cards) do
                if type(i) == "number" then
                    table.insert(SMODS.Challenges[challenge_key].restrictions.banned_cards, { id = item })
                else
                    table.insert(SMODS.Challenges[challenge_key].restrictions.banned_cards, { id = i, ids = item })
                end
            end
        end
        if restrictions.banned_tags then
            for i, item in ipairs(restrictions.banned_tags) do
                table.insert(SMODS.Challenges[challenge_key].restrictions.banned_tags, { id = item })
            end
        end
        if restrictions.banned_other then
            for i, item in ipairs(restrictions.banned_other) do
                table.insert(SMODS.Challenges[challenge_key].restrictions.banned_other, { id = item, type = "blind" }) -- update this if anything else ever goes into Other
            end
        end
    end
end
