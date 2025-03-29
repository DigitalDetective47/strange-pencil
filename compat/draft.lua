local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.c_draft_hittheclub)
    self:inject_card(SMODS.Centers.c_draft_thedarkside)
    self:inject_card(SMODS.Centers.c_draft_chessboard)
    self:inject_card(SMODS.Centers.c_draft_bloodandiron)
end