local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.j_theclub)
end
