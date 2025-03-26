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
				StrangeLib.dynablind.update_blind_scores()
				return true
			end,
		}))
	end,
	unredeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.multiplier
				StrangeLib.dynablind.update_blind_scores()
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
				StrangeLib.dynablind.update_blind_scores()
				return true
			end,
		}))
	end,
	unredeem = function(self, card)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.multiplier
				StrangeLib.dynablind.update_blind_scores()
				return true
			end,
		}))
	end,
})

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
