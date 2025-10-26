SMODS.current_mod.optional_features = { cardareas = { discard = true, deck = true }, quantum_enhancements = true }

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

StrangeLib.update_challenge_restrictions("challenge_bans.json")
StrangeLib.load_compat()

local main_menu_hook = Game.main_menu
function Game:main_menu(change_context)
    main_menu_hook(self, change_context)
    G.title_top.cards[1]:set_base(G.P_CARDS.C_A, true)
end
