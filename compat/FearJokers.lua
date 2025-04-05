local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.j_tma_Fractal)
    self:inject_card(SMODS.Centers.c_tma_nightfall)
end

StrangeLib.bulk_add(SMODS.Challenges.c_pencil_immutable.restrictions.banned_cards, {
    { id = "j_tma_PlagueDoctor" },
    { id = "j_tma_Wildfire" },
    { id = "c_tma_nightfall" },
    { id = "c_tma_burnout" },
    { id = "c_tma_glimmer" },
})
