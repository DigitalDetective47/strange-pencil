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
	loc_vars = function(self, info_queue)
		return { vars = { self.config.multiplier } }
	end,
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.multiplier
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / self.config.multiplier
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
	loc_vars = function(self, info_queue)
		return { vars = { self.config.multiplier } }
	end,
	requires = { "v_pencil_half_chip" },
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.multiplier
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / self.config.multiplier
				return true
			end,
		}))
	end,
})

if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Vouchers"] then -- Tier 3 vouchers should only appear with Cryptid Vouchers enabled
	SMODS.Voucher({
		key = "sqrt",
		atlas = "vouchers",
		pos = { x = 0, y = 2 },
		config = { exponent = 0.5 },
		loc_vars = function(self, info_queue)
			return { vars = { self.config.exponent } }
		end,
		requires = { "v_pencil_vision" },
		redeem = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.starting_params.ante_scaling_exponential = G.GAME.starting_params.ante_scaling_exponential * self.config.exponent
					return true
				end,
			}))
		end,
		unredeem = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.starting_params.ante_scaling_exponential = G.GAME.starting_params.ante_scaling_exponential / self.config.exponent
					return true
				end,
			}))
		end,
	})
end
