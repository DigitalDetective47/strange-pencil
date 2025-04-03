local eternal = { banned_cards = { { id = "c_pencil_chisel" } } }

return {
    c_omelette_1 = {
        banned_cards = {
            { id = "j_pencil_forbidden_one" },
        },
    },
    c_city_1 = eternal,
    c_knife_1 = eternal,
    c_non_perishable_1 = eternal,
    c_medusa_1 = eternal,
    c_typecast_1 = eternal,
    c_fragile_1 = {
        banned_cards = {
            { id = "c_pencil_plague" },
            { id = "c_pencil_parade" },
            { id = "c_pencil_chisel" },
        }
    },
    c_monolith_1 = eternal,
    c_jokerless_1 = {
        banned_cards = {
            { id = "p_pencil_clubs" },
        },
        banned_tags = {
            { id = "tag_pencil_clubs" },
        },
        banned_other = {
            { id = "bl_pencil_lock", type = "blind" },
        },
    },
}
