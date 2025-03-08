SMODS.Challenge({
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
})

-- Apply debuff for "Ride or Die" challenge
local debuff_hand_hook = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
    if G.GAME.modifiers.pencil_most_played_only then
        if G.GAME.first_hand and G.GAME.first_hand ~= handname then
            return true
        end
        if not check then
            G.GAME.first_hand = handname
        end
    end
    return debuff_hand_hook(self, cards, hand, handname, check)
end

-- Debuff text for "Ride or Die" challenge
local debuff_text_hook = Blind.get_loc_debuff_text
function Blind:get_loc_debuff_text()
    if G.GAME.modifiers.pencil_most_played_only then
        return 'Play only 1 hand type this run [' .. localize(G.GAME.first_hand, 'poker_hands') .. ']'
    end
    return debuff_text_hook(self)
end

SMODS.Challenge({
    key = "immutable",
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
            { id = "c_pencil_plague" },
            { id = "c_pencil_parade" },
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
        banned_other = {
            { id = "bl_pencil_lock", type = "blind" },
        },
    },
})

if next(SMODS.find_mod("YART")) then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "c_yart_rmagician" },
        { id = "c_yart_rempress" },
        { id = "c_yart_rheirophant" },
        { id = "c_yart_rlovers" },
        { id = "c_yart_rchariot" },
        { id = "c_yart_rjustice" },
        { id = "c_yart_rwheel_of_fortune" },
        { id = "c_yart_rstrength" },
        { id = "c_yart_rdeath" },
        { id = "c_yart_rtemperance" },
        { id = "c_yart_rdevil" },
        { id = "c_yart_rtower" },
        { id = "c_yart_rstar" },
        { id = "c_yart_rmoon" },
        { id = "c_yart_rsun" },
        { id = "c_yart_rworld" },
    })
end

if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config.Blinds then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other, {
        { id = "bl_cry_oldhouse",  type = "blind" },
        { id = "bl_cry_oldarm",    type = "blind" },
        { id = "bl_cry_oldpillar", type = "blind" },
        { id = "bl_cry_oldflint",  type = "blind" },
        { id = "bl_cry_oldmark",   type = "blind" },
    })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config["Code Cards"] then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "c_cry_variable" },
        { id = "c_cry_malware" },
        { id = "c_cry_seed" },
        -- { id = "c_cry_hook" },
        { id = "c_cry_class" },
        { id = "c_cry_merge" },
        { id = "c_cry_multiply" },
    })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config["Exotic Jokers"] then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_gemino" })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config["Misc."] then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "c_cry_eclipse" },
        { id = "c_cry_meld" },
        { id = "c_cry_seraph" },
    })
    -- table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_other, { id = "cry_double_sided", type="edition" })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config["Misc. Jokers"] then
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_cards, { id = "j_cry_fspinner" })
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "j_cry_kscope" },
        { id = "j_cry_seal_the_deal" },
    })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config.Spectrals then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "c_cry_lock" },
        { id = "c_cry_vacuum" },
        { id = "c_cry_hammerspace" },
        { id = "c_cry_replica" },
        { id = "c_cry_typhoon" },
        -- { id = "c_cry_source" },
    })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config.Spooky then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        { id = "j_cry_ghost" },
        { id = "j_cry_jawbreaker" },
        { id = "j_cry_cotton_candy" },
        { id = "j_cry_brittle" },
        { id = "j_cry_chocolate_dice" },
    })
end
if next(SMODS.find_mod("Cryptid")) and SMODS.find_mod("Cryptid")[1].config.Vouchers then
    StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
        -- { id = "v_cry_double_vision" },
        { id = "v_cry_double_slit" },
        { id = "v_cry_double_down" },
    })
end
