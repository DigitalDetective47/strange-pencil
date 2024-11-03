SMODS.Atlas({
    key = "indexes",
    path = "indexes.png",
    px = 71,
    py = 95,
})

SMODS.ConsumableType({
    key = "index",
    primary_colour = HEX("FFFFFF"),
    secondary_colour = HEX("FF0000"),
    shop_rate = 4,
    loc_txt = {},
})
SMODS.UndiscoveredSprite({
    key = "index",
    atlas = "indexes",
    pos = { x = 0, y = 0 },
})

SMODS.Consumable({
    key = "replica",
    set = "index",
    atlas = "indexes",
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, center)
        return { vars = { self.config.selections } }
    end,
    cost = 5,
    config = { selections = 1 },
    can_use = function(self, card)
        local targets = {}
        for k, v in ipairs(G.consumeables.highlighted) do
            if v.ability.set == "Unique" or not v.ability.consumeable then
                return false
            end
            if v ~= card then
                table.insert(targets, v)
            end
        end
        if G.shop_jokers ~= nil then
            for k, v in ipairs(G.shop_jokers.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_booster ~= nil then
            for k, v in ipairs(G.shop_booster.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_voucher ~= nil then
            for k, v in ipairs(G.shop_voucher.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.pack_cards ~= nil then
            for k, v in ipairs(G.pack_cards.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.hand ~= nil then
            for k, v in ipairs(G.hand.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        return #targets ~= 0 and #targets <= card.ability.selections and
            #G.consumeables.cards + #targets - (card.area == G.consumeables and 1 or 0) <= G.consumeables.config.card_limit
    end,
    use = function(self, card, area, copier)
        local targets = {}
        local targets = {}
        for k, v in ipairs(G.consumeables.highlighted) do
            if v.ability.set == "Unique" or not v.ability.consumeable then
                return false
            end
            if v ~= card then
                table.insert(targets, v)
            end
        end
        if G.shop_jokers ~= nil then
            for k, v in ipairs(G.shop_jokers.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_booster ~= nil then
            for k, v in ipairs(G.shop_booster.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_voucher ~= nil then
            for k, v in ipairs(G.shop_voucher.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.pack_cards ~= nil then
            for k, v in ipairs(G.pack_cards.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.hand ~= nil then
            for k, v in ipairs(G.hand.highlighted) do
                if v.ability.set == "Unique" or not v.ability.consumeable then
                    return false
                end
                if v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        for k, v in ipairs(targets) do
            local consume = create_card("Consumeables", G.consumables, nil, nil, nil, nil, v.config.center.key, nil)
            copy_card(v, consume)
            consume:add_to_deck()
            G.consumeables:emplace(consume)
        end
    end,
})

SMODS.Consumable({
    key = "counterfeit",
    set = "index",
    atlas = "indexes",
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, center)
        return { vars = { self.config.dollars } }
    end,
    cost = 5,
    config = { dollars = 15 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        ease_dollars(card.ability.dollars)
    end,
})

SMODS.Consumable({
    key = "chisel",
    set = "index",
    atlas = "indexes",
    pos = { x = 3, y = 0 },
    cost = 5,
    can_use = function(self, card)
        return #G.jokers.highlighted == 1 and
            (G.jokers.highlighted[1].ability.perishable or G.jokers.highlighted[1].pinned or G.jokers.highlighted[1].ability.rental or G.jokers.highlighted[1].ability.eternal)
    end,
    use = function(self, card, area, copier)
        local target = G.jokers.highlighted[1]
        target:flip()
        play_sound("card1", 0.9)
        target.ability.perishable = nil
        target.pinned = nil
        target:set_rental(nil)
        target:set_eternal(nil)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.3,
            func = function()
                play_sound("gold_seal", 1.2, 0.4)
                target:juice_up(0.3, 0.3)
                card:juice_up(0.3, 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.35,
            func = function()
                target:flip()
                play_sound("card1", 1.1)
                return true
            end,
        }))
    end,
})

SMODS.Consumable({
    key = "peek",
    set = "index",
    atlas = "indexes",
    pos = { x = 4, y = 0 },
    cost = 5,
    can_use = function(self, card)
        for k, v in ipairs(G.hand.cards or {}) do
            if v.facing == "back" then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        for k, v in ipairs(G.hand.cards) do
            if v.facing == "back" then
                v:flip()
            end
        end
    end,
})

SMODS.Consumable({
    key = "peek",
    set = "index",
    atlas = "indexes",
    pos = { x = 4, y = 0 },
    cost = 5,
    can_use = function(self, card)
        for k, v in ipairs(G.hand.cards or {}) do
            if v.facing == "back" then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        for k, v in ipairs(G.hand.cards) do
            if v.facing == "back" then
                v:flip()
            end
        end
    end,
})

SMODS.Consumable({
    key = "mixnmatch",
    set = "index",
    atlas = "indexes",
    pos = { x = 5, y = 0 },
    cost = 5,
    can_use = function(self, card)
        return #G.hand.highlighted - (card.area == G.hand and 1 or 0) == 2
    end,
    use = function(self, card, area, copier)
        local left = false
        local right = false
        for k, v in ipairs(G.hand.highlighted) do
            if v == card then
            elseif left then
                right = v
            else
                left = v
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.15,
            func = function()
                left:flip()
                play_sound("card1", 1.15 - (1 - 0.999) / (2 - 0.998) * 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.15,
            func = function()
                right:flip()
                play_sound("card1", 1.15 - (2 - 0.999) / (2 - 0.998) * 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function()
                local left_suit_prefix = string.sub(left.base.suit, 1, 1) .. '_'
                local left_rank_suffix = left.base.id
                if left_rank_suffix < 10 then
                    left_rank_suffix = tostring(left_rank_suffix)
                elseif left_rank_suffix == 10 then
                    left_rank_suffix = 'T'
                elseif left_rank_suffix == 11 then
                    left_rank_suffix = 'J'
                elseif left_rank_suffix == 12 then
                    left_rank_suffix = 'Q'
                elseif left_rank_suffix == 13 then
                    left_rank_suffix = 'K'
                elseif left_rank_suffix == 14 then
                    left_rank_suffix = 'A'
                end
                local right_suit_prefix = string.sub(right.base.suit, 1, 1) .. '_'
                local right_rank_suffix = right.base.id
                if right_rank_suffix < 10 then
                    right_rank_suffix = tostring(right_rank_suffix)
                elseif right_rank_suffix == 10 then
                    right_rank_suffix = 'T'
                elseif right_rank_suffix == 11 then
                    right_rank_suffix = 'J'
                elseif right_rank_suffix == 12 then
                    right_rank_suffix = 'Q'
                elseif right_rank_suffix == 13 then
                    right_rank_suffix = 'K'
                elseif right_rank_suffix == 14 then
                    right_rank_suffix = 'A'
                end
                right:set_base(G.P_CARDS[left_suit_prefix .. left_rank_suffix])
                left:set_base(G.P_CARDS[right_suit_prefix .. right_rank_suffix])
                card:juice_up(0.3, 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.85,
            func = function()
                left:flip()
                play_sound("card1", 1.15 - (1 - 0.999) / (2 - 0.998) * 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.15,
            func = function()
                right:flip()
                play_sound("card1", 1.15 - (2 - 0.999) / (2 - 0.998) * 0.3)
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
})