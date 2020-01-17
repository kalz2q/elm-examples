module Animation002 exposing (main, view)

-- Create animations that spin, wave, and zig-zag.
-- This one is a little red wagon bumping along a dirt road.
--
-- Learn more about the playground here:
--   https://package.elm-lang.org/packages/evancz/elm-playground/latest/
--

import Playground exposing (..)


main =
    animation view


view : Playground.Time -> List Playground.Shape
view time =
    [ square orange 30
    , square blue 200
        |> fade (zigzag 0 1 10 time)
    ]
