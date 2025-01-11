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
                    "Earn {C:money}$4{} at end of round",
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
            j_pencil_jake = {
                name = "Anachronic Hipster",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "when {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
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
            b_pencil_diseased = {
                name = "Plagued Deck",
                text = {
                    "All {C:attention}playing cards",
                    "are {C:attention,T:m_pencil_diseased}Diseased Cards",
                    "Cards cannot change enhancements",
                    "{s:0.8,C:inactive}Reminds of {s:0.8,C:inactive,T:b_cry_cry-perishable_deck}Perishable Deck",
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
                    "Extremely large blind",
                }
            },
            bl_pencil_arrow = {
                name = "The Arrow",
                text = {
                    "Retrigger abilities",
                    "are disabled",
                }
            },
        },
        Enhanced = {
            m_pencil_diseased = {
                name = "Diseased Card",
                text = {
                    "Infects adjacent played cards",
                    "Destroyed after {C:attention}#2#{} rounds",
                    "{C:inactive}({C:attention}#1#{C:inactive} remaining)"
                }
            },
        },
        Tarot = {
            c_pencil_plague = {
                name = "The Plague",
                text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a {C:attention}Diseased Card",
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
        },
        Spectral = {
            c_pencil_negative_space = {
                name = "Negative Space",
                text = {
                    "Create {C:attention}#1#{} random {C:purple,E:1}Eternal{}",
                    "{C:dark_edition}Negative{} card for each",
                    "slot currently visible",
                    "{C:inactive,s:0.8}Cards added to shop are free",
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
        },
        alt_texture = {
            alt_tex_tspa_spectral = {
                c_pencil_negative_space = { badge = 'spectrans_card' },
            }
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
            p_pencil_workshop_1 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_2 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_3 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
            p_pencil_workshop_4 = {
                name = "Arcana Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                }
            },
        }
    },
    misc = {
        challenge_names = {
            c_pencil_debug = "Debug Challenge",
            c_pencil_permamouth = "Ride or Die",
            c_pencil_immutable = "Immutable",
            c_pencil_meltingpot = "Melting Pot",
        },
        dictionary = {
            k_index = "Index",
            b_index_cards = "Index Cards",
            k_infected = "Infected!",
            k_cracked = "Cracked!"
        },
        labels = {
            index = "Index",
        },
        v_text = {
            ch_c_pencil_most_played_only = { "Play only 1 hand type this run" },
            ch_c_pencil_endless_scaling = { "Endless blind scaling" },
            ch_c_pencil_epic_spam = { "Create a random {C:cry_epic}Epic{C:attention} Joker{} when Boss Blind is defeated" },
        },
    }
}
