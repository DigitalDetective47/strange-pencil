SMODS.Atlas({
	key = "vouchers",
	path = "vouchers.png",
	px = 71,
	py = 95,
})

SMODS.Voucher({
	key = "half_chip",
	atlas = "vouchers",
	pos = { x = 0, y = 0 },
	config = { multiplier = 0.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.multiplier } }
	end,
	redeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.multiplier
				return true
			end,
		}))
	end,
	unredeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.multiplier
				return true
			end,
		}))
	end,
})

SMODS.Voucher({
	key = "vision",
	atlas = "vouchers",
	pos = { x = 0, y = 1 },
	config = { multiplier = 0.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.multiplier } }
	end,
	requires = { "v_pencil_half_chip" },
	redeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.multiplier
				return true
			end,
		}))
	end,
	unredeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.multiplier
				return true
			end,
		}))
	end,
})

if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load and SMODS.Mods.Cryptid.config.Vouchers then -- Tier 3 vouchers should only appear with Cryptid Vouchers enabled
	SMODS.Voucher({
		key = "sqrt",
		atlas = "vouchers",
		pos = { x = 0, y = 2 },
		config = { exponent = 0.5 },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.exponent } }
		end,
		requires = { "v_pencil_vision" },
		redeem = function(self, card)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.starting_params.ante_scaling_exponential = G.GAME.starting_params.ante_scaling_exponential *
						card.ability.exponent
					return true
				end,
			}))
		end,
		unredeem = function(self, card)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.starting_params.ante_scaling_exponential = G.GAME.starting_params.ante_scaling_exponential /
						card.ability.exponent
					return true
				end,
			}))
		end,
	})
	table.insert(Cryptid.Megavouchers, "v_pencil_sqrt")
end

SMODS.Voucher({
	key = "pull",
	atlas = "vouchers",
	pos = { x = 1, y = 0 },
})

SMODS.Voucher({
	key = "overstock",
	atlas = "vouchers",
	pos = { x = 1, y = 1 },
	config = { extra = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	requires = { "v_pencil_pull" },
	redeem = function(self, card)
		G.GAME.index_pack_bonus = (G.GAME.index_pack_bonus or 0) + card.ability.extra
	end,
	unredeem = function(self, card)
		G.GAME.index_pack_bonus = G.GAME.index_pack_bonus - card.ability.extra
	end,
})
