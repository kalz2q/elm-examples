module Animation001 exposing (main, view)

-- Create animations that spin, wave, and zig-zag.
-- This one is a little red wagon bumping along a dirt road.
--
-- Learn more about the playground here:
--   https://package.elm-lang.org/packages/evancz/elm-playground/latest/
--
-- typeがわからないからわからないのかも。

import Playground exposing (..)


main =
    animation view


view : Playground.Time -> List Playground.Shape
view time =
    [ octagon darkGray 36
        |> moveLeft 100
        |> rotate (spin 3 time)
    , octagon darkGray 36
        |> moveRight 100
        |> rotate (spin 3 time)
    , rectangle red 300 80
        |> moveUp (wave 50 54 2 time)
        |> rotate (zigzag -2 2 8 time)
    ]
