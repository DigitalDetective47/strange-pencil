--- STEAMODDED HEADER
--- MOD_NAME: Strange Pencil
--- MOD_ID: StrangePencil
--- MOD_AUTHOR: [DigitalDetective47]
--- MOD_DESCRIPTION: A collection of random stuff that I've created and drawn in Paint.
--- PRIORITY: 0
--- PREFIX: pencil

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32,
})

SMODS.Challenge({
    key = "debug",
    rules = {
        modifiers = {
            { id = "dollars", value = 1e200 },
        }
    },
    jokers = {
        { id = "j_pencil_swimmers" },
        { id = "j_cry_gemino" }
    },
    consumeables = {
        { id = "c_cry_pointer" },
        { id = "c_cry_pointer" },
    },
    deck = {
        cards = { { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, { s = "S", r = "K", e = "m_steel" }, },
        type = 'Challenge Deck'
    },
})
local permamouth = {
    key = "permamouth",
    rules = {
        custom = {
            { id = "pencil_most_played_only" },
        },
    },
    vouchers = {
        { id = "v_telescope" },
        { id = "v_hieroglyph" },
    },
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
            { id = "j_obelisk" },
            { id = "j_cry_fspinner" },
        },
        banned_other = {
            { id = 'bl_ox',    type = 'blind' },
            { id = 'bl_eye',   type = 'blind' },
            { id = 'bl_mouth', type = 'blind' },
        }
    }
}
-- if (SMODS.Mods["Cryptid"] or {}).can_load and SMODS.Mods.Cryptid.config["Blinds"] then
--     table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldhouse", type = 'blind' })
--     table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldpillar", type = 'blind' })
--     table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldflint", type = 'blind' })
--     table.insert(permamouth.restrictions.banned_other, { id = "bl_cry_oldmark", type = 'blind' })
-- end

SMODS.Challenge(permamouth)
FirstHand = nil

SMODS.Atlas({
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
})

SMODS.Joker({
    key = "swimmers",
    config = { extra = { mult = 11 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult,
            },
        }
    end,
    rarity = 2,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            local enhancement = nil;
            for i = 1, #context.scoring_hand do
                if enhancement then
                    if context.scoring_hand[i].ability.name ~= enhancement then
                        return {}
                    end
                elseif context.scoring_hand[i].ability.name ~= "Default Base" then
                    enhancement = context.scoring_hand[i].ability.name
                else
                    return {}
                end
            end
            return {
                message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
                mult = card.ability.extra.mult,
                card = card,
            }
        end
    end,
})

SMODS.Atlas({
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95,
})

SMODS.Back({
    key = "royal",
    order = 3,
    config = { hand_size = -4, pencil_only_faces = true },
    -- loc_vars = function(self, info_queue, center)
    --     return {
    --         vars = {
    --             center.effect.config.hand_size < 0 and center.effect.config.hand_size or "+" .. center.effect.config.hand_size,
    --         },
    --     }
    -- end,
    pos = { x = 0, y = 0 },
    atlas = "decks",
})

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
        return #targets ~= 0 and #targets <= card.ability.selections and
            #G.consumeables + #targets - (card.area == G.consumeables and 1 or 0) <= G.consumeables.config.card_limit
    end,
    use = function(self, card, area, copier)
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
        for k, v in ipairs(targets) do
            local consume = create_card("Consumeables", G.consumables, nil, nil, nil, nil, v.config.center.key, nil)
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
