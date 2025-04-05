local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.j_prism_night)
    self:inject_card(SMODS.Centers.j_prism_pizza_ruc)
end

table.insert(SMODS.Challenges.c_pencil_permamouth.restrictions.banned_other,
    { id = "bl_prism_rose_club", type = "blind" })
StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
    { id = "j_prism_geo_hammer" },
    { id = "j_prism_medusa" },
    { id = "j_prism_promotion" },
    { id = "c_prism_myth_dwarf" },
    { id = "c_prism_myth_dragon" },
    { id = "c_prism_myth_twin" },
    { id = "c_prism_myth_wizard" },
    { id = "c_prism_myth_treant" },
    { id = "c_prism_myth_ooze" },
    { id = "c_prism_myth_colossus" },
    { id = "c_prism_myth_mirror" },
    { id = "c_prism_myth_druid" },
})
