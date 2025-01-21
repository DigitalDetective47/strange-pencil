local hook = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        G.GAME.pack_size = self.ability.extra
    end
    return hook(self)
end
