SMODS.current_mod.optional_features = { cardareas = { discard = true, deck = true }, post_trigger = true, quantum_enhancements = true }

for _, args in ipairs(JSON.decode(NFS.read(SMODS.current_mod.path .. "/atlas.json"))) do
    if type(args) == "string" then
        args = { key = args }
    end
    args.path = args.path or args.key .. ".png"
    args.px = args.px or 71
    args.py = args.py or 95
    SMODS.Atlas(args)
end

for _, filename in ipairs(NFS.getDirectoryItems(SMODS.current_mod.path)) do
    if filename ~= "main.lua" and filename:find("[^/]*%.lua$") then
        SMODS.load_file(filename)()
    end
end

---@param self Mod
---@param context CalcContext
---@return table?
function SMODS.current_mod.calculate(self, context)
    if context.press_play then
        G.GAME.hands_played = G.GAME.hands_played + 1
        StrangeLib.dynablind.update_blind_scores(StrangeLib.dynablind.find_blind("bl_pencil_glove"))
        G.GAME.hands_played = G.GAME.hands_played - 1
    elseif context.debuff_hand and G.GAME.modifiers.pencil_most_played_only then
        if G.GAME.first_hand and G.GAME.first_hand ~= context.scoring_name then
            return {
                debuff = true,
                debuff_text = "Play only 1 hand type this run [" .. localize(G.GAME.first_hand, "poker_hands") .. "]"
            }
        elseif not context.check then
            G.GAME.first_hand = context.scoring_name
        end
    elseif context.before and G.GAME.modifiers.covid_19 then
        for _, card in ipairs(context.scoring_hand) do
            if SMODS.pseudorandom_probability(card, "disease_exposure", 1, 10) then
                card:set_ability(SMODS.Centers.m_pencil_diseased, nil, true)
            end
        end
    elseif context.end_of_round then
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, false, 'pencil_paralyzed')
        end
        SMODS.Centers.j_pencil_killer:reset_target()
    end
end

---@param run_start boolean
function SMODS.current_mod.reset_game_globals(run_start)
    if run_start then
        SMODS.Centers.j_pencil_killer:reset_target()
    end
end

StrangeLib.update_challenge_restrictions("challenge_bans.json")
StrangeLib.load_compat()

local main_menu_hook = Game.main_menu
function Game:main_menu(change_context)
    main_menu_hook(self, change_context)
    G.title_top.cards[1]:set_base(G.P_CARDS.C_A, true)
end

if next(SMODS.find_mod("Balatest")) then
    for _, filename in ipairs(NFS.getDirectoryItems(SMODS.current_mod.path .. "/test")) do
        SMODS.load_file("test/" .. filename)()
    end
end
