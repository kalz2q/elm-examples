module Suit exposing (..)

import Random

type Suit
  = Hearts
  | Diamonds
  | Spades
  | Clubs

numToSuit : Int -> Suit
numToSuit num =
  case num of 
    0 -> Hearts
    1 -> Diamonds
    2 -> Spades
    _ -> Clubs

suitGenerator : Random.Generator Suit
suitGenerator =
  Random.map numToSuit (Random.int 0 3)
