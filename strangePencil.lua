SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34,
})
SMODS.load_file("blinds.lua")()
SMODS.load_file("challenges.lua")()
SMODS.load_file("decks.lua")()
SMODS.load_file("indexes.lua")()
SMODS.load_file("jokers.lua")()
SMODS.load_file("spectrals.lua")()
SMODS.load_file("tags.lua")()
SMODS.load_file("vouchers.lua")()

local hook = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        G.GAME.pack_size = self.ability.extra
    end
    return hook(self)
end
