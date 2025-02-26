local eternal = { banned_cards = { "c_pencil_chisel" } }
local no_enhancements = { banned_cards = { "c_pencil_plague", "c_pencil_parade" } }

return {
    c_omelette_1 = {
        banned_cards = {
            "j_pencil_forbidden_one",
        },
    },
    c_city_1 = eternal,
    c_knife_1 = eternal,
    c_non_perishable_1 = eternal,
    c_medusa_1 = eternal,
    c_typecast_1 = eternal,
    c_fragile_1 = {
        banned_cards = {
            "c_pencil_plague",
            "c_pencil_parade",
            "c_pencil_chisel",
        }
    },
    c_monolith_1 = eternal,
    c_jokerless_1 = {
        banned_cards = {
            "p_pencil_clubs"
        },
        banned_tags = {
            "tag_pencil_clubs",
        },
        banned_other = {
            "bl_pencil_lock",
        },
    },
    c_cry_ballin = no_enhancements,
    c_cry_dagger_war = eternal,
    c_cry_onlycard = {
        banned_cards = {
            p_pencil_index_1 = { "p_pencil_index_1", "p_pencil_index_2", "p_pencil_index_jumbo", "p_pencil_index_mega" },
            "p_pencil_clubs",
        },
        banned_tags = {
            "tag_pencil_workshop",
            "tag_pencil_index",
            "tag_pencil_clubs",
        },
    },
    c_cry_rng = {
        banned_cards = {
            "p_pencil_clubs",
        },
        banned_tags = {
            "tag_pencil_clubs",
        },
    },
    joker_poker = {
        banned_cards = {
            "j_pencil_doodlebob",
            "j_pencil_pencil",
        },
    },
}
