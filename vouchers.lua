---Shared redeem function for the blind scaling vouchers
---@param self SMODS.Voucher
---@param card Card
local function scaling_voucher_redeem(self, card)
	G.E_MANAGER:add_event(Event { func = function()
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.multiplier
		StrangeLib.dynablind.update_blind_scores()
		return true
	end })
end

SMODS.Voucher {
	key = "half_chip",
	attributes = { "xblindsize" },
	atlas = "vouchers",
	pos = { x = 0, y = 0 },
	config = { multiplier = 0.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.multiplier } }
	end,
	redeem = scaling_voucher_redeem,
}

SMODS.Voucher {
	key = "vision",
	attributes = { "xblindsize" },
	atlas = "vouchers",
	pos = { x = 0, y = 1 },
	config = { multiplier = 0.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.multiplier } }
	end,
	unlocked = false,
	locked_loc_vars = function(self, info_queue, card)
		return { vars = { 10, G.PROFILES[G.SETTINGS.profile].career_stats.pencil_bosses_disabled or 0 } }
	end,
	check_for_unlock = function(self, args)
		return args.type == "boss_disabled" and G.PROFILES[G.SETTINGS.profile].career_stats.pencil_bosses_disabled >= 10
	end,
	requires = { "v_pencil_half_chip" },
	redeem = scaling_voucher_redeem,
}

SMODS.Voucher {
	key = "pull",
	attributes = { "booster" },
	atlas = "vouchers",
	pos = { x = 1, y = 0 },
}

SMODS.Voucher {
	key = "overstock",
	attributes = { "booster" },
	atlas = "vouchers",
	pos = { x = 1, y = 1 },
	config = { extra = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra } }
	end,
	unlocked = false,
	locked_loc_vars = function(self, info_queue, card)
		return { vars = { 50, G.PROFILES[G.SETTINGS.profile].career_stats.pencil_indexes_used_from_boosters or 0 } }
	end,
	check_for_unlock = function(self, args)
		return args.type == "boss_disabled" and
			G.PROFILES[G.SETTINGS.profile].career_stats.pencil_indexes_used_from_boosters >= 50
	end,
	requires = { "v_pencil_pull" },
	redeem = function(self, card)
		G.GAME.index_pack_bonus = (G.GAME.index_pack_bonus or 0) + card.ability.extra
	end,
}
