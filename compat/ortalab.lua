local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.j_ortalab_abstemious)
    self:inject_card(SMODS.Centers.j_ortalab_pitch_mitch)
    self:inject_card(SMODS.Centers.j_ortalab_basalt_column)
end

table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other, { id = "bl_ortalab_sheep", type = "blind" })
StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
    { id = "j_ortalab_virus" },
    { id = "c_ortalab_lot_melon" },
    { id = "c_ortalab_lot_umbrella" },
    { id = "c_ortalab_lot_mandolin" },
    { id = "c_ortalab_lot_ladder" },
    { id = "c_ortalab_lot_siren" },
    { id = "c_ortalab_lot_bird" },
    { id = "c_ortalab_lot_pear" },
    { id = "c_ortalab_lot_flag" },
    { id = "c_ortalab_lot_harp" }, -- unclear
    { id = "c_ortalab_lot_rose" },
    { id = "c_ortalab_lot_dandy" },
    { id = "c_ortalab_lot_boot" },
    { id = "c_ortalab_lot_parrot" },
    { id = "c_ortalab_lot_umbrella" },
    { id = "c_ortalab_lot_heart" },
    { id = "c_ortalab_lot_hand" },
    { id = "c_ortalab_lot_tree" },
    { id = "c_ortalab_zod_scorpio" },
    { id = "c_ortalab_zod_gemini" },
    { id = "c_ortalab_zod_taurus" },
    { id = "c_ortalab_zod_capr" },
    { id = "c_ortalab_zod_sag" },
    { id = "c_ortalab_zod_libra" },
    { id = "c_ortalab_zod_pisces" },
    { id = "c_ortalab_zod_cancer" },
    { id = "c_ortalab_zod_leo" },
})
table.insert(SMODS.Challenges.c_pencil_immutable.restrictions.banned_other, { id = "bl_ortalab_hammer", type = "blind" })
