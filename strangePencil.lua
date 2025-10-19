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

StrangeLib.load_compat()

for challenge_key, restrictions in pairs(SMODS.load_file("challenge_restrictions.lua")()) do
    for category, bans in pairs(restrictions) do
        StrangeLib.bulk_add(SMODS.Challenges[challenge_key].restrictions[category], bans)
    end
end

local main_menu_hook = Game.main_menu
function Game:main_menu(change_context)
    main_menu_hook(self, change_context)
    G.title_top.cards[1]:set_base(G.P_CARDS.C_A, true)
end
