local clubs_pack_inject_hook = SMODS.ObjectTypes.clubs_pack.inject
function SMODS.ObjectTypes.clubs_pack.inject(self)
    clubs_pack_inject_hook(self)
    self:inject_card(SMODS.Centers.c_yart_rmoon)
end

StrangeLib.update_challenge_restrictions("compat/YART/challenge_bans.json")
