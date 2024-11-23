local permamouth = {
    key = "permamouth",
    rules = {
        custom = {
            { id = "pencil_most_played_only" },
        },
    },
    vouchers = {
        { id = "v_telescope" },
        { id = "v_hieroglyph" },
    },
    deck = {
        type = "Challenge Deck"
    },
    restrictions = {
        banned_cards = {
            { id = "j_obelisk" },
        },
        banned_other = {
            { id = "bl_ox",      type = "blind" },
            { id = "bl_psychic", type = "blind" },
            { id = "bl_eye",     type = "blind" },
            { id = "bl_mouth",   type = "blind" },
        }
    }
}

local immutable = {
    key = "immutable",
    deck = {
        type = "Challenge Deck"
    },
    restrictions = {
        banned_cards = {
            { id = "j_vampire" },
            { id = "j_midas_mask" },
            { id = "c_magician" },
            { id = "c_empress" },
            { id = "c_heirophant" },
            { id = "c_lovers" },
            { id = "c_chariot" },
            { id = "c_justice" },
            { id = "c_wheel_of_fortune" },
            { id = "c_strength" },
            { id = "c_death" },
            { id = "c_devil" },
            { id = "c_tower" },
            { id = "c_star" },
            { id = "c_moon" },
            { id = "c_sun" },
            { id = "c_world" },
            { id = "c_talisman" },
            { id = "c_aura" },
            { id = "c_sigil" },
            { id = "c_ouija" },
            { id = "c_ectoplasm" },
            { id = "c_deja_vu" },
            { id = "c_hex" },
            { id = "c_trance" },
            { id = "c_medium" },
            { id = "c_pencil_chisel" },
            { id = "c_pencil_mixnmatch" },
        },
        banned_tags = {
            { id = "tag_pencil_workshop" },
        },
        banned_other = {},
    },
}

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Blinds"] then
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldhouse", type = "blind" })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldarm", type = "blind" })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldpillar", type = "blind" })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldflint", type = "blind" })
    table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldmark", type = "blind" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Code Cards"] then
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_variable" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_malware" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_seed" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_hook" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_class" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_merge" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_multiply" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Exotic Jokers"] then
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_gemino" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Misc."] then
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_eclipse" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_meld" })
    -- table.insert(immutable.restrictions.banned_other, { id = "cry_double_sided", type="edition" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Misc. Jokers"] then
    table.insert(permamouth.restrictions.banned_cards, { id = "j_cry_fspinner" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_kscope" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_seal_the_deal" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Spectrals"] then
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_lock" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_vacuum" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_hammerspace" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_replica" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_typhoon" })
    table.insert(immutable.restrictions.banned_cards, { id = "c_cry_source" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Spooky"] then
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_ghost" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_jawbreaker" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_cotton_candy" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_brittle" })
    table.insert(immutable.restrictions.banned_cards, { id = "j_cry_chocolate_dice" })
end
if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Vouchers"] then
    -- table.insert(immutable.restrictions.banned_cards, { id = "v_cry_double_vision" })
    table.insert(immutable.restrictions.banned_cards, { id = "v_cry_double_slit" })
    table.insert(immutable.restrictions.banned_cards, { id = "v_cry_double_down" })
end
SMODS.Challenge(permamouth)
SMODS.Challenge(immutable)

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Epic Jokers"] then
    SMODS.Challenge({
        key = "meltingpot",
        rules = {
            custom = {
                { id = "pencil_endless_scaling" },
                { id = "pencil_epic_spam" },
            }
        },
        deck = {
            type = "Challenge Deck"
        },
    })
end
