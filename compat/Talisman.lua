SMODS.Joker:take_ownership("pencil_square", {
    calculate = function(self, card, context)
        if context.joker_main then
            return { echips = card.ability.exponent }
        end
    end,
}, true)

SMODS.Blind {
    key = "caret2",
    boss = { showdown = true },
    dollars = 8,
    in_pool = function()
        return StrangeLib.dynablind.get_blind_score(G.P_BLINDS.bl_small) >
            to_big(
                1.9769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368e308
            ) -- Boss should only appear after naneinf
    end,
    boss_colour = G.C.WHITE,
    pos = { x = 0, y = 8 },
    atlas = "blinds",
    mult = 2,
    score = function(self, base)
        return self.disabled and base or self.mult ^ base
    end,
    disable = SMODS.Blinds.bl_pencil_caret.disable,
}
