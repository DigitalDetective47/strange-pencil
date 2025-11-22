SMODS.PokerHandPart {
    key = "dichrome",
    func = function(hand)
        ---@alias Membership { [Card]: true, n: integer }
        ---@type table<string, Membership>
        local suited_doubles = {}
        ---@type table<string, Membership>
        local suited_triples = {}
        for key, _ in pairs(SMODS.Suits) do
            ---@type Membership
            local membership = { n = 0 }
            for _, card in ipairs(hand) do
                if card:is_suit(key, nil, true) then
                    membership[card] = true
                    membership.n = membership.n + 1
                end
            end
            if membership.n >= 2 then
                suited_doubles[key] = membership
                if membership.n >= 3 then
                    suited_triples[key] = membership
                end
            end
        end
        ---@type table<Card, true>
        local scoring = {}
        for triple_suit, triple_membership in pairs(suited_triples) do
            for double_suit, double_membership in pairs(suited_doubles) do
                if triple_suit ~= double_suit then
                    ---@type Membership
                    local union = { n = 0 }
                    for card, _ in pairs(triple_membership) do
                        if card ~= "n" then
                            union[card] = true
                            union.n = union.n + 1
                        end
                    end
                    for card, _ in pairs(double_membership) do
                        if card ~= "n" and not union[card] then
                            union[card] = true
                            union.n = union.n + 1
                        end
                    end
                    if union.n >= 5 then
                        union.n = nil
                        SMODS.merge_defaults(scoring, union)
                    end
                end
            end
        end
        return next(scoring) and { StrangeLib.as_list(scoring) } or {}
    end
}
---`loc_vars` implementation for planet cards
---@param self SMODS.Consumable
---@param info_queue table[]
---@param card Card
---@return { vars: table }
local function loc_vars(self, info_queue, card)
    return {
        vars = {
            G.GAME.hands[card.ability.hand_type].level,
            localize(card.ability.hand_type, 'poker_hands'),
            G.GAME.hands[card.ability.hand_type].l_mult,
            G.GAME.hands[card.ability.hand_type].l_chips,
            colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
        }
    }
end

SMODS.PokerHand {
    key = "dichrome",
    chips = 15,
    mult = 2,
    l_chips = 10,
    l_mult = 1,
    example = { { "C_Q", true }, { "C_7", true }, { "C_2", true }, { "D_T", true }, { "D_4", true } },
    visible = true,
    evaluate = function(parts, hand)
        return parts.pencil_dichrome
    end
}
SMODS.Consumable {
    key = "voyager",
    set = "Planet",
    atlas = "planets",
    pos = { x = 0, y = 0 },
    config = { hand_type = "pencil_dichrome" },
    loc_vars = loc_vars,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_planet_spacecraft"), G.C.SECONDARY_SET.Planet, nil, 1.2)
    end
}

SMODS.PokerHand {
    key = "dichrome_straight",
    chips = 55,
    mult = 6,
    l_chips = 35,
    l_mult = 4,
    example = { { "S_8", true }, { "S_7", true }, { "C_6", true }, { "S_5", true }, { "C_4", true } },
    visible = true,
    evaluate = function(parts, hand)
        return next(parts.pencil_dichrome) and next(parts._straight) and
            { SMODS.merge_lists(parts.pencil_dichrome, parts._straight) } or {}
    end
}
SMODS.Consumable {
    key = "rover",
    set = "Planet",
    atlas = "planets",
    pos = { x = 1, y = 0 },
    config = { hand_type = "pencil_dichrome_straight" },
    loc_vars = loc_vars,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_planet_av"), G.C.SECONDARY_SET.Planet, nil, 1.2)
    end
}

SMODS.PokerHand {
    key = "dichrome_house",
    chips = 100,
    mult = 10,
    l_chips = 40,
    l_mult = 3,
    example = { { "H_A", true }, { "H_A", true }, { "S_A", true }, { "S_6", true }, { "S_6", true } },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.pencil_dichrome) and next(parts._3) and #parts._2 >= 2 and
            { SMODS.merge_lists(parts.pencil_dichrome, parts._all_pairs) } or {}
    end
}
SMODS.Consumable {
    key = "junk",
    set = "Planet",
    atlas = "planets",
    pos = { x = 2, y = 0 },
    config = { hand_type = "pencil_dichrome_house" },
    loc_vars = loc_vars,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_planet_debris"), G.C.SECONDARY_SET.Planet, nil, 1.2)
    end
}

SMODS.PokerHand {
    key = "dichrome_house2",
    chips = 130,
    mult = 13,
    l_chips = 40,
    l_mult = 4,
    example = { { "D_3", true }, { "D_3", true }, { "D_3", true }, { "S_2", true }, { "S_2", true } },
    visible = false,
    evaluate = function(parts, hand)
        ---@type table<table, Membership>
        local doubles = {}
        ---@type table<table, Membership>
        local triples = {}
        for suit, suit_obj in pairs(SMODS.Suits) do
            for rank, rank_obj in pairs(SMODS.Ranks) do
                ---@type Membership
                local membership = { n = 0 }
                for _, card in ipairs(hand) do
                    if card.base.value == rank and card:is_suit(suit, nil, true) then
                        membership[card] = true
                        membership.n = membership.n + 1
                    end
                end
                if membership.n >= 2 then
                    local key = G.P_CARDS[("%s_%s"):format(suit_obj.card_key, rank_obj.card_key)]
                    doubles[key] = membership
                    if membership.n >= 3 then
                        triples[key] = membership
                    end
                end
            end
        end
        ---@type table<Card, true>
        local scoring = {}
        for triple_card, triple_membership in pairs(triples) do
            for double_card, double_membership in pairs(doubles) do
                if triple_card.suit ~= double_card.suit and triple_card.value ~= double_card.value then
                    ---@type Membership
                    local union = { n = 0 }
                    for card, _ in pairs(triple_membership) do
                        if card ~= "n" then
                            union[card] = true
                            union.n = union.n + 1
                        end
                    end
                    for card, _ in pairs(double_membership) do
                        if card ~= "n" and not union[card] then
                            union[card] = true
                            union.n = union.n + 1
                        end
                    end
                    if union.n >= 5 then
                        union.n = nil
                        SMODS.merge_defaults(scoring, union)
                    end
                end
            end
        end
        return next(scoring) and { StrangeLib.as_list(scoring) } or {}
    end
}
SMODS.Consumable {
    key = "iss",
    set = "Planet",
    atlas = "planets",
    pos = { x = 3, y = 0 },
    config = { hand_type = "pencil_dichrome_house2" },
    loc_vars = loc_vars,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_planet_human_sattelite"), G.C.SECONDARY_SET.Planet, nil, 1.2)
    end
}

SMODS.PokerHand {
    key = "dichrome_five",
    chips = 150,
    mult = 15,
    l_chips = 45,
    l_mult = 3,
    example = { { "C_7", true }, { "C_7", true }, { "C_7", true }, { "H_7", true }, { "H_7", true } },
    visible = false,
    evaluate = function(parts, hand)
        return next(parts.pencil_dichrome) and next(parts._5) and
            { SMODS.merge_lists(parts.pencil_dichrome, parts._5) } or {}
    end
}
SMODS.Consumable {
    key = "sphere",
    set = "Planet",
    atlas = "planets",
    pos = { x = 4, y = 0 },
    config = { hand_type = "pencil_dichrome_five" },
    loc_vars = loc_vars,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_planet_generator"), G.C.SECONDARY_SET.Planet, nil, 1.2)
    end
}
