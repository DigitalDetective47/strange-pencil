local cartomancer_stringify_hook = Card.cart_to_string
function Card:cart_to_string(args)
    return cartomancer_stringify_hook(self, args) ..
        (SMODS.has_enhancement(self, "m_pencil_flagged") and self.ability.pos and self.ability.pos <= #G.deck.cards and tostring(self.ability.pos) or "")
end
