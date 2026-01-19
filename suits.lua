---template `in_pool` function for strange suits
---@param self SMODS.Suit
---@param args table<string, any>
---@return boolean
local function in_pool(self, args)
    if args then
        if args.initial_deck then
            return false
        elseif args.suit ~= "" then
            return G.GAME.selected_back and G.GAME.selected_back.name == "b_pencil_suit" and
                SMODS.pseudorandom_probability(nil, pseudoseed("b_pencil_suit"), 1, 4, nil, true)
        end
    end
    if G.playing_cards then
        for _, card in ipairs(G.playing_cards) do
            if card.base.suit == self.key then
                return true
            end
        end
    end
    return false
end

---template `loc_vars` that returns just the card's face value
---@param self SMODS.Suit
---@param info_queue any[]
---@param card Card?
---@return { vars: [number | "n"] }
local function nominal_or_n(self, info_queue, card)
    return { vars = { card and card.base.nominal or "n" } }
end

---template `loc_vars` function for suit changers
---@param self SMODS.Consumable
---@param info_queue any[]
---@param card Card
---@return { vars: [integer] }
local function loc_vars(self, info_queue, card)
    table.insert(info_queue, SMODS.merge_defaults(
        SMODS.Suits[card.ability.suit_conv]:loc_vars(info_queue), { key = card.ability.suit_conv, set = "Other" }))
    return { vars = { card.ability.max_highlighted } }
end

---template `loc_vars` function for suit chip jokers
---@param self SMODS.Joker
---@param info_queue any[]
---@param card Card
---@return { vars: [number, string] }
local function j_loc_vars(self, info_queue, card)
    table.insert(info_queue, SMODS.merge_defaults(
        SMODS.Suits[card.ability.extra.suit]:loc_vars(info_queue), { key = card.ability.extra.suit, set = "Other" }))
    return { vars = { card.ability.extra.s_chips, localize(card.ability.extra.suit, "suits_singular") } }
end

---template `in_pool` function for suit chip jokers
---@param self SMODS.Joker
---@param args table
---@return boolean
local function j_in_pool(self, args)
    for _, card in ipairs(G.playing_cards) do
        if card.base.suit == self.config.extra.suit then
            return true
        end
    end
    return false
end

---template `calculate` function for suit chip jokers
---@param self SMODS.Joker
---@param card Card
---@param context CalcContext
---@return { chips: number }?
local function j_calculate(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
        return { chips = card.ability.extra.s_chips }
    end
end

SMODS.ObjectType {
    key = "strange_suit_spectral",
    default = "c_pencil_multiply",
}

SMODS.Suit {
    key = "mults",
    card_key = "M",
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card and 0.5 * card.base.nominal or "0.5n" } }
    end,
    lc_atlas = "suits",
    hc_atlas = "hc_suits",
    lc_ui_atlas = "suit_ui",
    hc_ui_atlas = "hc_suit_ui",
    lc_colour = G.C.MULT,
    hc_colour = { 1, 0, 0, 1 },
    in_pool = in_pool,
    strange = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { mult = 0.5 * card.base.nominal }
        end
    end,
}
SMODS.Consumable {
    key = "multiply",
    set = "Spectral",
    atlas = "suits",
    pos = { x = 13, y = 0 },
    config = { suit_conv = "pencil_mults", max_highlighted = 3 },
    loc_vars = loc_vars,
    pools = { strange_suit_spectral = true },
}
SMODS.Joker {
    key = "adultery",
    config = { extra = { s_chips = 30, suit = "pencil_mults" } },
    loc_vars = j_loc_vars,
    rarity = 1,
    pos = { x = 14, y = 0 },
    atlas = "suits",
    cost = 5,
    in_pool = j_in_pool,
    calculate = j_calculate,
}

SMODS.Suit {
    key = "dollars",
    card_key = "$",
    pos = { y = 1 },
    ui_pos = { x = 1, y = 0 },
    loc_vars = nominal_or_n,
    lc_atlas = "suits",
    hc_atlas = "hc_suits",
    lc_ui_atlas = "suit_ui",
    hc_ui_atlas = "hc_suit_ui",
    lc_colour = G.C.MONEY,
    hc_colour = G.C.YELLOW,
    in_pool = in_pool,
    strange = true,
    calculate = function(self, card, context)
        ---@type number
        local dollars = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
        if context.main_scoring and context.cardarea == G.play then
            if dollars < card.base.nominal then
                SMODS.Centers.j_pencil_emerald.activate = true
                ---@type number
                local ret = card.base.nominal - dollars
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + ret
                return { dollars = ret }
            else
                SMODS.Centers.j_pencil_emerald.activate = false
            end
        end
    end,
}
SMODS.Consumable {
    key = "liquidation",
    set = "Spectral",
    atlas = "suits",
    pos = { x = 13, y = 1 },
    config = { suit_conv = "pencil_dollars", max_highlighted = 3 },
    loc_vars = loc_vars,
    pools = { strange_suit_spectral = true },
}
SMODS.Joker {
    key = "fraud",
    config = { extra = { s_chips = 30, suit = "pencil_dollars" } },
    loc_vars = j_loc_vars,
    rarity = 1,
    pos = { x = 14, y = 1 },
    atlas = "suits",
    cost = 5,
    in_pool = j_in_pool,
    calculate = j_calculate,
}

SMODS.Suit {
    key = "oracles",
    card_key = "O",
    pos = { y = 2 },
    ui_pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, card)
        if card then
            return { vars = { SMODS.get_probability_vars(card, card.base.nominal, 20) } }
        else
            ---@type number, number
            local _, ret = SMODS.get_probability_vars(nil, 1, 20)
            return { vars = { "n", ret } }
        end
    end,
    lc_atlas = "suits",
    hc_atlas = "hc_suits",
    lc_ui_atlas = "suit_ui",
    hc_ui_atlas = "hc_suit_ui",
    lc_colour = G.C.SECONDARY_SET.Tarot,
    hc_colour = HEX("8C00FF"),
    in_pool = in_pool,
    strange = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and SMODS.pseudorandom_probability(card, self.key, card.base.nominal, 20) then
            G.E_MANAGER:add_event(Event { func = function()
                card:juice_up(0.3, 0.5)
                ---@type CreateCard
                local addition = { set = "Tarot" }
                if next(SMODS.find_card("j_pencil_crystal")) then
                    addition.no_edition = true
                    addition.edition = "e_negative"
                end
                SMODS.add_card(addition)
                return true
            end })
        end
    end,
}
SMODS.Consumable {
    key = "charm",
    set = "Spectral",
    atlas = "suits",
    pos = { x = 13, y = 2 },
    config = { suit_conv = "pencil_oracles", max_highlighted = 3 },
    loc_vars = loc_vars,
    pools = { strange_suit_spectral = true },
}
SMODS.Joker {
    key = "blasphemy",
    config = { extra = { s_chips = 30, suit = "pencil_oracles" } },
    loc_vars = j_loc_vars,
    rarity = 1,
    pos = { x = 14, y = 2 },
    atlas = "suits",
    cost = 5,
    in_pool = j_in_pool,
    calculate = j_calculate,
}

SMODS.Suit {
    key = "swords",
    card_key = "S",
    pos = { y = 3 },
    ui_pos = { x = 1, y = 1 },
    loc_vars = nominal_or_n,
    lc_atlas = "suits",
    hc_atlas = "hc_suits",
    lc_ui_atlas = "suit_ui",
    hc_ui_atlas = "hc_suit_ui",
    lc_colour = HEX("738096"),
    hc_colour = HEX("374649"),
    in_pool = in_pool,
    strange = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event { func = function()
                        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling *
                            (1 - card.base.nominal / 100)
                        card.ability[self.key] = true
                        StrangeLib.dynablind.update_blind_scores({ [G.GAME.blind_on_deck] = true })
                        return true
                    end })
                    SMODS.calculate_effect({
                        message = localize { type = "variable", key = "a_blind_reduced", vars = { card.base.nominal } }
                    }, card)
                end
            }
        elseif context.playing_card_end_of_round and card.ability[self.key] then
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / (1 - card.base.nominal / 100)
            card.ability[self.key] = nil
        end
    end,
}
SMODS.Consumable {
    key = "rift",
    set = "Spectral",
    atlas = "suits",
    pos = { x = 13, y = 3 },
    config = { suit_conv = "pencil_swords", max_highlighted = 3 },
    loc_vars = loc_vars,
    pools = { strange_suit_spectral = true },
}
SMODS.Joker {
    key = "murder",
    config = { extra = { s_chips = 30, suit = "pencil_swords" } },
    loc_vars = j_loc_vars,
    rarity = 1,
    pos = { x = 14, y = 3 },
    atlas = "suits",
    cost = 5,
    in_pool = j_in_pool,
    calculate = j_calculate,
}
