local hook = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        G.GAME.pack_size = self.ability.extra
    end
    return hook(self)
end

SMODS.ObjectType({
    key = "clubs_pack",
    default = "j_gluttenous_joker",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
        -- insert base game meme jokers
        self:inject_card(G.P_CENTERS.j_gluttenous_joker)
        self:inject_card(G.P_CENTERS.j_blackboard)
        self:inject_card(G.P_CENTERS.j_onyx_agate)
        self:inject_card(G.P_CENTERS.j_seeing_double)
        self:inject_card(G.P_CENTERS.c_moon)
        if next(SMODS.find_mod("YART")) then
            self:inject_card(SMODS.Centers.c_yart_rmoon)
        end
    end
})
SMODS.ObjectType({
    key = "clubs_legendary",
    default = "j_pencil_club",
    cards = {},
})

SMODS.Booster({
    key = "clubs",
    kind = "Special",
    atlas = "boosters",
    pos = { x = 4, y = 1 },
    soul_pos = { x = 5, y = 1 },
    cost = 6,
    config = { extra = 5, choose = 1 },
    ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.SUITS.Clubs, special_colour = G.C.SO_1.Clubs, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.SO_1.Clubs, lighten(G.C.SUITS.Clubs, 0.4), lighten(G.C.SUITS.Clubs, 0.2), lighten(G.C.SO_1.Clubs, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local rng = pseudorandom('pencil_clubs_pack')
        if rng < 0.1 then
            local new = nil
            repeat
                if new then
                    new:remove()
                end
                new = SMODS.create_card(G.P_CENTERS.p_standard_jumbo_1:create_card(card, i))
                SMODS.change_base(new, "Clubs")
            until not SMODS.has_no_suit(new)
            return new
        elseif rng > 0.997 then
            return { set = "clubs_legendary", area = G.pack_cards, skip_materialize = true }
        else
            return { set = "clubs_pack", area = G.pack_cards, skip_materialize = true }
        end
    end,
    group_key = "k_clubs_pack",
})

SMODS.Tag({
    atlas = "tags",
    pos = { x = 2, y = 0 },
    config = { type = "new_blind_choice" },
    key = "clubs",
    min_ante = 4,
    loc_vars = function(self, info_queue)
        table.insert(info_queue, G.P_CENTERS.p_pencil_clubs)
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            if G.STATE ~= G.STATES.TAROT_PACK then
                G.GAME.PACK_INTERRUPT = G.STATE
            end
            tag:yep("+", G.C.SO_1.Clubs, function()
                local card = Card(
                    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                    G.CARD_W * 1.27,
                    G.CARD_H * 1.27,
                    G.P_CARDS.empty,
                    G.P_CENTERS["p_pencil_clubs"],
                    { bypass_discovery_center = true, bypass_discovery_ui = true }
                )
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = card } })
                card:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
})
