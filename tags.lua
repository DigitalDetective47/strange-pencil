StrangeLib.make_boosters("workshop",
    { { x = 0, y = 0 }, { x = 1, y = 0 }, { x = 2, y = 0 }, { x = 3, y = 0 } }, {}, {},
    {
        kind = "Workshop",
        no_doe = true,
        no_collection = true,
        weight = 0,
        draw_hand = true,
        ease_background_colour = G.P_CENTERS.p_arcana_normal_1.ease_background_colour,
        create_UIBox = create_UIBox_arcana_pack,
        particles = G.P_CENTERS.p_arcana_normal_1.particles,
        create_card = function(self, card, i)
            if i == 1 then
                return { key = "c_death", area = G.pack_cards, skip_materialize = true }
            elseif i == 2 then
                return { key = "c_hanged_man", area = G.pack_cards, skip_materialize = true }
            elseif i == 3 then
                return { key = "c_hermit", area = G.pack_cards, skip_materialize = true }
            else
                return G.P_CENTERS.p_arcana_normal_1:create_card(card, i)
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
                local card = Card(
                    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                    G.CARD_W * 1.27,
                    G.CARD_H * 1.27,
                    G.P_CARDS.empty,
                    SMODS.Centers["p_pencil_workshop_normal_" .. math.random(1, 4)],
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
