SMODS.Atlas({
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34,
})

SMODS.Booster({
    key = "workshop",
    kind = "Workshop",
    no_doe = true,
    pos = { x = 1, y = 0 },
    config = { extra = 3, choose = 1 },
    weight = 0,
    draw_hand = true,
    loc_vars = SMODS.Booster.loc_vars,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_UIBox = create_UIBox_arcana_pack,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        if i == 1 then
            return create_card("Tarot", G.pack_cards, nil, nil, true, true, "c_death")
        elseif i == 2 then
            return create_card("Tarot", G.pack_cards, nil, nil, true, true, "c_hanged_man")
        elseif i == 3 then
            return create_card("Tarot", G.pack_cards, nil, nil, true, true, "c_hermit")
        elseif G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            return create_card("Spectral", G.pack_cards, nil, nil, true, true, nil, 'ar2')
        else
            return create_card("Tarot", G.pack_cards, nil, nil, true, true, nil, 'ar1')
        end
    end,
    group_key = "k_tarot_pack",
})
SMODS.Tag({
    atlas = "tags",
    pos = { x = 0, y = 0 },
    config = { type = "new_blind_choice" },
    key = "workshop",
    loc_vars = function(self, info_queue)
        table.insert(info_queue, G.P_CENTERS.p_arcana_normal_2)
        table.insert(info_queue, G.P_CENTERS.c_death)
        table.insert(info_queue, G.P_CENTERS.c_hanged_man)
        table.insert(info_queue, G.P_CENTERS.c_hermit)
        return { vars = {} }
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            if G.STATE ~= G.STATES.TAROT_PACK then
                G.GAME.PACK_INTERRUPT = G.STATE
            end
            tag:yep("+", G.C.SECONDARY_SET.Tarot, function()
                local key = "p_pencil_workshop"
                local card = Card(
                    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                    G.CARD_W * 1.27,
                    G.CARD_H * 1.27,
                    G.P_CARDS.empty,
                    G.P_CENTERS[key],
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
