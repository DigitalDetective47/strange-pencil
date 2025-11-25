SMODS.Challenge {
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
        banned_other = {
            { id = "bl_ox",      type = "blind" },
            { id = "bl_psychic", type = "blind" },
            { id = "bl_eye",     type = "blind" },
            { id = "bl_mouth",   type = "blind" },
        }
    }
}

SMODS.Challenge {
    key = "immutable",
    restrictions = {
        banned_cards = {
            { id = "j_vampire" },
            { id = "j_midas_mask" },
            { id = "j_pencil_night_club" },
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
            { id = "c_pencil_kfc" },
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
}
