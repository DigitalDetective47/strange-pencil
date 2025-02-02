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
local hook = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
    if G.GAME.modifiers.pencil_most_played_only then
        if G.GAME.first_hand and G.GAME.first_hand ~= handname then
            return true
        end
        if not check then
            G.GAME.first_hand = handname
        end
    end
    return hook(self, cards, hand, handname, check)
end

-- Debuff text for "Ride or Die" challenge
local hook2 = Blind.get_loc_debuff_text
function Blind:get_loc_debuff_text()
    if G.GAME.modifiers.pencil_most_played_only then
        return 'Play only 1 hand type this run [' .. localize(G.GAME.first_hand, 'poker_hands') .. ']'
    end
    return hook2(self)
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
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rmagician" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rempress" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rheirophant" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rlovers" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rchariot" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rjustice" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rwheel_of_fortune" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rstrength" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rdeath" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rtemperance" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rdevil" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rtower" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rstar" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rmoon" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rsun" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_yart_rworld" })
end

if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config.Blinds then
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
        { id = "bl_cry_oldhouse", type = "blind" })
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
        { id = "bl_cry_oldarm", type = "blind" })
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
        { id = "bl_cry_oldpillar", type = "blind" })
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
        { id = "bl_cry_oldflint", type = "blind" })
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
        { id = "bl_cry_oldmark", type = "blind" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config["Code Cards"] then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_variable" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_malware" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_seed" })
    -- table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_hook" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_class" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_merge" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_multiply" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config["Exotic Jokers"] then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_gemino" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config["Misc."] then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_eclipse" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_meld" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_seraph" })
    -- table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_other, { id = "cry_double_sided", type="edition" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config["Misc. Jokers"] then
    table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_cards, { id = "j_cry_fspinner" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_kscope" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_seal_the_deal" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config.Spectrals then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_lock" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_vacuum" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_hammerspace" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_replica" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_typhoon" })
    -- table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "c_cry_source" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config.Spooky then
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_ghost" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_jawbreaker" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_cotton_candy" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_brittle" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "j_cry_chocolate_dice" })
end
if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config.Vouchers then
    -- table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "v_cry_double_vision" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "v_cry_double_slit" })
    table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, { id = "v_cry_double_down" })
end

if next(SMODS.find_mod("Cryptid")) and next(SMODS.find_mod("Cryptid")).config["Epic Jokers"] then
    SMODS.Challenge({
        key = "meltingpot",
        rules = {
            custom = {
                { id = "pencil_endless_scaling" },
                { id = "pencil_epic_spam" },
            }
        },
    })
end

-- Endless scaling for first 8 antes
local hook3 = get_blind_amount
function get_blind_amount(ante)
    if G.GAME.modifiers.pencil_endless_scaling then
        local amounts = {
            to_big(300)
        }
        if ante < 1 then return to_big(100) end
        if ante <= 1 then return amounts[ante] end
        local a, b, c, d = amounts[1], 1.6, ante - 1, 1 + 0.2 * (ante - 1)
        local amount = a * (b + (to_big(0.75) * c) ^ d) ^ c
        if (amount:lt(R.E_MAX_SAFE_INTEGER)) then
            local exponent = to_big(10) ^ (math.floor(amount:log10() - to_big(1))):to_number()
            amount = math.floor(amount / exponent):to_number() * exponent
        end
        amount:normalize()
        return amount
    end
    return hook3(ante)
end
