return {
    descriptions = {
        Joker = {
            j_pencil_swimmers = {
                name = "Synchronized Swimmers",
                text = {
                    "Each scored card gives {C:mult}+#1#{} Mult",
                    "if all scoring cards have",
                    "the same {C:attention}Enhancement",
                    "{C:inactive}(Played cards must be {C:attention}Enhanced{C:inactive}){}"
                }
            },
            j_pencil_lass = {
                name = "The Lass",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult",
                    "per {C:clubs}Queen of Clubs{}",
                    "in your full deck",
                    "{C:inactive,s:0.8}(Minimum of {X:mult,C:white,s:0.8}X1{C:inactive,s:0.8})",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})"
                }
            },
            j_pencil_left_arm = {
                name = "Left Arm of The Forbidden One",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                }
            },
            j_pencil_right_arm = {
                name = "Right Arm of The Forbidden One",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                }
            },
            j_pencil_left_leg = {
                name = "Left Leg of The Forbidden One",
                text = {
                    "{C:chips}+#1#{} Chips",
                }
            },
            j_pencil_right_leg = {
                name = "Right Leg of The Forbidden One",
                text = {
                    "{C:mult}+#1#{} Mult",
                }
            },
            j_pencil_forbidden_one = {
                name = "The Forbidden One",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Instantly win if you have",
                    "{C:attention}Left Arm of The Forbidden One{},",
                    "{C:attention}Left Leg of The Forbidden One{},",
                    "{C:attention}Right Arm of The Forbidden One{},",
                    "and {C:attention}Right Leg of The Forbidden One{}",
                }
            },
            j_pencil_doodlebob = {
                name = "Doodle Bob",
                text = {
                    "{C:blue}+#1#{} Chips per {C:blue}Index{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:blue}+#2#{C:inactive})",
                },
            },
            j_pencil_pencil = {
                name = "Strange Pencil",
                text = {
                    "Creates a random {C:blue}Index",
                    "card when a consumable of",
                    "another type is used",
                    "{C:inactive}(Must have room)",
                },
            },
            j_pencil_forty_seven = {
                name = "Forty-seven",
                text = {
                    "Retrigger each played {C:attention}4 #1#",
                    "for each {C:attention}7{} held in hand",
                },
            },
            j_pencil_square = {
                name = "Square Chip",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Chips",
                },
            },
            j_pencil_pee_pants = {
                name = "Pee Pants",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "if played hand contains",
                    "a {C:attention}Two Pair",
                    "and at least {C:attention}#2#{} {C:diamonds}Diamonds",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
                },
            },
            j_pencil_squeeze = {
                name = "Egg Squeeze",
                text = {
                    "Gains sell value equal to",
                    "the number of rounds this",
                    "Joker has been held",
                    "{C:inactive}(Currently {C:money}$#3#{C:inactive})",
                    "{C:green}#1# in #2#{} chance this",
                    "card is destroyed",
                    "at end of round",
                }
            },
            j_pencil_eclipse = {
                name = "Solar Eclipse",
                text = {
                    "Gains {C:mult}+#1#{} Mult when",
                    "a {C:clubs}Club{} is scored",
                    "Loses {C:mult}-#2#{} Mult when",
                    "a {C:hearts}Heart{} is scored",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_pencil_club = {
                name = "Club.",
                text = {
                    "All played {C:clubs}Clubs{} give {X:mult,C:white}X#1#{} Mult",
                    "and are retriggered {C:attention}#2#{} times",
                    "Destroyed if a non-{C:clubs}Club{} is played"
                }
            },
            j_pencil_calendar = {
                name = "Calendar",
                text = {
                    "Adds current day of month to chips",
                    "Adds current month to mult",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive}, {C:mult}+#2#{C:inactive})",
                }
            },
            j_pencil_doot = {
                name = "Doot",
                text = {
                    "Earn {C:money}$#1#{} if scored hand",
                    "contains a {C:attention}Diseased Card",
                    "and a {C:attention}Flagged Card",
                }
            },
            j_pencil_stonehenge = {
                name = "Stonehenge",
                text = {
                    "Gains {C:chips}+#1#{} Chips when purchased",
                    "Value is persistent",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_pencil_ratio = {
                name = "Ratio",
                text = {
                    "If scored hand does not contain",
                    "your most common suit, gain XMult",
                    "equal to the proportion of your deck",
                    "which is that suit; otherwise {C:attention}reset",
                    "Does not scale if multiple suits are tied",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                    "{s:0.8,C:inactive}[{s:0.8,C:attention}#1#{s:0.8,C:inactive}, +{s:0.8,X:mult,C:white}X#2#{s:0.8,C:inactive}]",
                },
            },
            j_pencil_commie = {
                name = "Communist",
                text = {
                    "Balance ranks",
                    "of scored cards",
                }
            },
            j_pencil_night_club = {
                name = "Night Club",
                text = {
                    "Convert all scoring",
                    "cards to {C:clubs}Clubs",
                    "on {C:attention}final hand{} of round",
                }
            },
        },
        Back = {
            b_pencil_royal = {
                name = "Royal Deck",
                text = {
                    "Start run with",
                    "only {C:attention}Face Cards",
                    "in your deck",
                    "{C:attention}#1#{} hand size",
                },
            },
            b_pencil_normal = {
                name = "Normal Deck",
                text = {
                    "All {C:attention}Ranks{} in deck",
                    "are randomized over a",
                    "{C:attention}normal distribution",
                    "{C:inactive}(mean {C:attention}#1#{C:inactive}, standard deviation {C:attention}#2#{C:inactive})",
                },
            },
            b_pencil_booster = {
                name = "Boosted Booster Deck",
                text = {
                    "Take {C:attention}#1#{} extra card",
                    "from each {C:attention}Booster Pack",
                },
            },
            b_pencil_slow_roll = {
                name = "Slow Roller's Deck",
                text = {
                    "Reroll cost persists",
                    "between shops",
                    "Rerolls start at {C:money}$#1#",
                    "Reroll cost is reduced by {C:money}$#2#",
                    "when Blind is defeated",
                    "{s:0.8,C:inactive}Cannot go below 0",
                },
            },
        },
        Blind = {
            bl_pencil_glove = {
                name = "Parchment Glove",
                text = {
                    "Gains 0.1X Base per",
                    "hand played this run",
                }
            },
            bl_pencil_caret = {
                name = "The Point",
                text = {
                    "Extremely",
                    "large blind",
                }
            },
            bl_pencil_arrow = {
                name = "The Arrow",
                text = {
                    "Retrigger abilities",
                    "are disabled",
                }
            },
            bl_pencil_lock = {
                name = "The Lock",
                text = {
                    "Apply {C:attention}Pinned{} to",
                    "a random {C:attention}Joker",
                    "when hand is played",
                }
            },
            bl_pencil_star = {
                name = "Fluorescent Star",
                text = {
                    "Only the highest",
                    "ranked card scores",
                }
            },
            bl_pencil_fence = {
                name = "The Fence",
                text = {
                    "Apply {C:attention}Paralyzed{} to",
                    "all {C:attention}Jokers{} triggered",
                    "on first hand of round",
                }
            },
            bl_pencil_flower = {
                name = "The Flower",
                text = {
                    "-1 Hand Selection Limit",
                    "per hand played this round",
                }
            },
        },
        Enhanced = {
            m_pencil_diseased = {
                name = "Diseased Card",
                text = {
                    "Infects adjacent scoring cards",
                    "Destroyed after {C:attention}#2#{} rounds",
                    "{C:inactive}({C:attention}#1#{C:inactive} remaining)"
                }
            },
            m_pencil_flagged = {
                name = "Flagged Card",
                text = {
                    "#1#{C:attention}#2#",
                    "Cannot be flipped",
                }
            },
        },
        Tarot = {
            c_pencil_plague = {
                name = "The Plague",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}Diseased Card",
                }
            },
            c_pencil_parade = {
                name = "The Parade",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Flagged Cards",
                }
            }
        },
        index = {
            c_pencil_replica = {
                name = "Replica",
                text = {
                    "Create a copy of up to",
                    "{C:attention}#1#{} selected {C:attention}consumable",
                    "{C:inactive}(Must have room)",
                }
            },
            c_pencil_counterfeit = {
                name = "Counterfeit",
                text = {
                    "Gain {C:money}$#1#",
                }
            },
            c_pencil_chisel = {
                name = "Chisel",
                text = {
                    "Remove all {C:attention}stickers{}",
                    "from a selected {C:attention}joker",
                    "{C:inactive,s:0.8}(Excludes stake win stickers)",
                }
            },
            c_pencil_peek = {
                name = "Peek",
                text = {
                    "Flip all {C:attention}face down{} cards",
                }
            },
            c_pencil_mixnmatch = {
                name = "Mix & Match",
                text = {
                    "Swap the {C:attention}rank{} and {C:attention}suit{} of",
                    "two selected cards in hand",
                }
            },
            c_pencil_fractal = {
                name = "Fractal",
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:blue}Index{} cards",
                    "{C:inactive}(Must have room)",
                }
            },
            c_pencil_ono99 = {
                name = "O'no 99",
                text = {
                    "Destroy all {C:attention}O'no 99{}s in your",
                    "consumable slots, and create a random",
                    "{C:blue}Index{} card for each {C:attention}O'no 99{} destroyed",
                    "{C:inactive,s:0.8}Created cards inherit the {C:dark_edition,s:0.8}edition",
                    "{C:inactive,s:0.8} of the destroyed {C:attention,s:0.8}O'no 99",
                    "{C:attention}O'no 99{} cannot appear again",
                    "All consumable slots must be",
                    "filled with {C:attention}O'no 99{}s to use",
                    "Cannot be sold",
                }
            },
        },
        Spectral = {
            c_pencil_negative_space = {
                name = "Negative Space",
                text = {
                    "Create {C:attention}#1#{} random {C:purple,E:1}Eternal{}",
                    "{C:dark_edition}Negative{} for each",
                    "joker slot you have",
                }
            },
            c_pencil_pulsar = {
                name = "Pulsar",
                text = {
                    "{C:attention}#1#{} the level",
                    "of your most played",
                    "{C:legendary,E:1}poker hand",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive})",
                }
            },
        },
        Tag = {
            tag_pencil_workshop = {
                name = "Workshop Tag",
                text = {
                    "Gives a free {C:tarot}Arcana Pack",
                    "with {C:attention}Death{}, {C:attention}The Hanged Man{},",
                    "and {C:attention}The Hermit{}",
                },
            },
            tag_pencil_index = {
                name = "Scribble Tag",
                text = {
                    "Gives a free",
                    "{C:blue}Jumbo Doodle Pack",
                },
            },
            tag_pencil_clubs = {
                name = "Club Tag",
                text = {
                    "Gives a free",
                    "{C:clubs}Clubs Pack",
                },
            }
        },
        Voucher = {
            v_pencil_half_chip = {
                name = "Half Chip",
                text = {
                    "{C:red}X#1#{} base Blind size",
                }
            },
            v_pencil_vision = {
                name = "Miraculous Vision",
                text = {
                    "{C:red}X#1#{} base Blind size",
                }
            },
            v_pencil_sqrt = {
                name = "Squared Roots",
                text = {
                    "{C:red}^#1#{} base Blind size",
                }
            },
            v_pencil_pull = {
                name = "Storage Facility",
                text = {
                    "Cards from {C:blue}Index Packs{} can be",
                    "saved in your consumable slots",
                }
            },
            v_pencil_overstock = {
                name = "Mass Storage",
                text = {
                    "All {C:blue}Index Packs{} contain",
                    "{C:attention}#1#{} additional card",
                }
            },
        },
        Stake = {
            stake_pencil_charred = {
                name = "Charred Stake",
                text = {
                    "Played cards can become {c:attention}Diseased{}",
                    "{C:inactive,s:0.8}(Infects adjacent cards,",
                    "{C:inactive,s:0.8}destroyed after 5 rounds)",
                    "{s:0.8}Applies all previous Stakes",
                }
            },
            stake_pencil_neon = {
                name = "Neon Stake",
                text = {
                    "Shop can have {C:attention}Paralyzed{} Jokers",
                    "{C:inactive,s:0.8}(Debuffed 1 in 4 rounds)",
                    "{s:0.8}Applies all previous Stakes",
                }
            },
        },
        Other = {
            undiscovered_index = {
                name = "Not Discovered",
                text = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does"
                }
            },
            p_pencil_workshop_normal_1 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_normal_2 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_normal_3 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_normal_4 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_index_normal_1 = {
                name = "Doodle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:blue}Index{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_index_normal_2 = {
                name = "Doodle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:blue}Index{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_index_jumbo_1 = {
                name = "Jumbo Doodle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:blue}Index{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_index_mega_1 = {
                name = "Mega Doodle Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:blue}Index{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_clubs = {
                name = "Clubs Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:clubs}Club{}-related cards",
                }
            },
            pencil_paralyzed = {
                name = "Paralyzed",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "to be {C:red}debuffed{}",
                    "each round",
                }
            },
            pencil_charred_sticker = {
                name = "Charred Sticker",
                text={
                    "Used this Joker",
                    "to win on {C:attention}Charred",
                    "{C:attention}Stake{} difficulty",
                },
            },
            pencil_neon_sticker = {
                name = "Neon Sticker",
                text={
                    "Used this Joker",
                    "to win on {C:attention}Neon",
                    "{C:attention}Stake{} difficulty",
                },
            }
        }
    },
    misc = {
        challenge_names = {
            c_pencil_permamouth = "Ride or Die",
            c_pencil_immutable = "Immutable",
        },
        dictionary = {
            k_index = "Index",
            b_index_cards = "Index Cards",
            k_index_pack = "Doodle Pack",
            k_clubs_pack = "Clubs Pack",
            k_infected_ex = "Infected!",
            k_cracked_ex = "Cracked!",
            k_paralyzed_ex = "Paralyzed!",
            k_clubbin_ex = "Clubbin!",
            b_pull = "PULL",
        },
        ranks = {
            pencil_sneven = "Sñeven",
        },
        labels = {
            index = "Index",
            pencil_paralyzed = "Paralyzed"
        },
        v_text = {
            ch_c_pencil_most_played_only = { "Play only 1 hand type this run" },
        },
        v_dictionary = {
            a_echips = "^#1#",
        }
    }
}
