return {
    descriptions = {
        Joker = {
            j_pencil_swimmers = {
                name = "Synchronized Swimmers",
                text = {
                    "Each scored card gives {C:mult}+#1#{} mult",
                    "if all scoring cards have",
                    "the same {C:attention}Enhancement",
                    "{C:inactive}(Played cards must be {C:attention}Enhanced{C:inactive}){}"
                }
            },
            j_pencil_lass = {
                name = "The Lass",
                text = {
                    "Gives {X:mult,C:white}X#1#{} mult",
                    "per {C:clubs}Queen of Clubs{}",
                    "in your full deck",
                    "{C:inactive,s:0.8}(Minimum of {X:mult,C:white,s:0.8}X1{C:inactive,s:0.8})",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult)"
                }
            },
            j_pencil_left_arm = {
                name = "Left Arm of The Forbidden One",
                text = {
                    "{X:chips,C:white}X#1#{} chips",
                }
            },
            j_pencil_right_arm = {
                name = "Right Arm of The Forbidden One",
                text = {
                    "{X:mult,C:white}X#1#{} mult",
                }
            },
            j_pencil_left_leg = {
                name = "Left Leg of The Forbidden One",
                text = {
                    "{C:chips}+#1#{} chips",
                }
            },
            j_pencil_right_leg = {
                name = "Right Leg of The Forbidden One",
                text = {
                    "{C:mult}+#1#{} mult",
                }
            },
            j_pencil_forbidden_one = {
                name = "The Forbidden One",
                text = {
                    "Earn {C:money}$4{} at end of round",
                    "If you have",
                    "{C:attention}Left Arm of The Forbidden One{},",
                    "{C:attention}Right Arm of The Forbidden One{},",
                    "{C:attention}Left Leg of The Forbidden One{},",
                    "and {C:attention}Right Leg of The Forbidden One{},",
                    "create a {C:dark_edition}Negative{} {C:cry_code}Rigged{} {C:attention}Googol",
                    "{C:attention}Play Card{} when {C:attention}Blind{} is selected"
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
                    "{C:attention}-4{} hand size",
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
            p_pencil_workshop = {
                name = "Arcana Pack [Workshop Tag]",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:tarot} Tarot{} cards to",
                    "be used immediately",
                    "{s:0.8,C:inactive}(Generated by Workshop Tag)",
                }
            }
        }
    },
    misc = {
        challenge_names = {
            c_pencil_debug = "Debug Challenge",
            c_pencil_permamouth = "Ride or Die",
            c_pencil_immutable = "Immutable",
        },
        dictionary = {
            k_index = "Index",
            b_index_cards = "Index Cards",
        },
        labels = {
            index = "Index",
        },
        v_text = {
            ch_c_pencil_most_played_only = { "Play only 1 hand type this run" },
        },
    }
}
