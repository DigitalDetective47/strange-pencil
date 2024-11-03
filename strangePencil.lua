--- STEAMODDED HEADER
--- MOD_NAME: Strange Pencil
--- MOD_ID: StrangePencil
--- MOD_AUTHOR: [DigitalDetective47]
--- MOD_DESCRIPTION: A collection of random stuff that I've created and drawn in Paint.
--- PRIORITY: 0
--- PREFIX: pencil

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32,
})
SMODS.load_file("challenges.lua")()
SMODS.load_file("decks.lua")()
SMODS.load_file("indexes.lua")()
SMODS.load_file("jokers.lua")()
