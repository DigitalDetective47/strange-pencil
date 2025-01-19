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
    default = "c_pencil_ono99",
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
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.selections } }
    end,
    cost = 5,
    config = { selections = 1 },
    can_use = function(self, card)
        local targets = {}
        for k, v in ipairs(G.consumeables.highlighted) do
            if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                table.insert(targets, v)
            end
        end
        if G.shop_jokers ~= nil then
            for k, v in ipairs(G.shop_jokers.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_booster ~= nil then
            for k, v in ipairs(G.shop_booster.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_vouchers ~= nil then
            for k, v in ipairs(G.shop_vouchers.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.pack_cards ~= nil then
            for k, v in ipairs(G.pack_cards.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.hand ~= nil then
            for k, v in ipairs(G.hand.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        return #targets ~= 0 and #targets <= card.ability.selections and
            #G.consumeables.cards + #targets - (card.area == G.consumeables and 1 or 0) <=
            G.consumeables.config.card_limit
    end,
    use = function(self, card, area, copier)
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
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
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_booster ~= nil then
            for k, v in ipairs(G.shop_booster.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.shop_vouchers ~= nil then
            for k, v in ipairs(G.shop_vouchers.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.pack_cards ~= nil then
            for k, v in ipairs(G.pack_cards.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        if G.hand ~= nil then
            for k, v in ipairs(G.hand.highlighted) do
                if v.ability.set ~= "Unique" and v.ability.consumeable and v ~= card then
                    table.insert(targets, v)
                end
            end
        end
        for k, v in ipairs(targets) do
            local consume = create_card("Consumeables", G.consumables, nil, nil, nil, nil, v.config.center.key, nil)
            copy_card(v, consume)
            if SMODS.Mods.incantation and SMODS.Mods.incantation.can_load then
                consume:setQty(1)
            end
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
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.dollars } }
    end,
    cost = 5,
    config = { dollars = 15 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
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
        if #G.jokers.highlighted ~= 1 then
            return false
        end
        for k, v in pairs(SMODS.Stickers) do
            if G.jokers.highlighted[1].ability[v.key] then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
        local target = G.jokers.highlighted[1]
        target:flip()
        play_sound("card1", 0.9)
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
            delay = 0.1,
            func = function()
                for k, v in pairs(SMODS.Stickers) do
                    v:apply(target, nil)
                end
                return true
            end,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.85,
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
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
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
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
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
                local temp = { suit = left.base.suit, rank = left.base.value }
                SMODS.change_base(left, right.base.suit, right.base.value)
                SMODS.change_base(right, temp.suit, temp.rank)
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

SMODS.Consumable({
    key = "fractal",
    set = "index",
    atlas = "indexes",
    pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.cards } }
    end,
    cost = 5,
    config = { cards = 2 },
    can_use = function(self, card)
        return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
    end,
    use = function(self, card, area, copier)
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
        for i = 1, math.min(card.ability.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local new = SMODS.create_card({ set = "index" })
                        new:add_to_deck()
                        G.consumeables:emplace(new)
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
})

SMODS.Consumable({
    key = "ono99",
    set = "index",
    atlas = "indexes",
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.cards_needed } }
    end,
    cost = 5,
    config = { cards_needed = 4 },
    can_use = function(self, card)
        if SMODS.Mods.incantation and SMODS.Mods.incantation.can_load then
            local total = 0
            for k, v in ipairs(SMODS.find_card("c_pencil_ono99", true)) do
                total = total + v:getQty()
                if total >= card.ability.cards_needed then
                    return true
                end
            end
            return false
        else
            return #SMODS.find_card("c_pencil_ono99", true) >= card.ability.cards_needed
        end
    end,
    use = function(self, card, area, copier)
        G.GAME.consumeable_usage_total.pencil_index = (G.GAME.consumeable_usage_total.pencil_index or 0) + 1
        G.GAME.banned_keys.c_pencil_ono99 = true
        play_sound('timpani')
        for k, v in ipairs(SMODS.find_card("c_pencil_ono99")) do
            if not v.ability.eternal then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        for i = 1, SMODS.Mods.incantation and SMODS.Mods.incantation.can_load and v:getQty() or 1, 1 do
                            SMODS.add_card({ set = "index", no_edition = true, edition = v.edition })
                        end
                        v:start_dissolve()
                        return true
                    end
                }))
            end
        end
    end,
})

local hook = Card.can_sell_card
function Card:can_sell_card(context)
    return self.config.center.key ~= "c_pencil_ono99" and hook(self, context)
end
