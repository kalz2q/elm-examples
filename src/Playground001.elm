module Playground001 exposing (main, tree, triangleEye, view)

import Playground exposing (..)



-- Playground.animation : (Playground.Time -> List Playground.Shape) -> Program () Playground.Animation Playground.Msg


main : Program () Playground.Animation Playground.Msg
main =
    animation view


view : Playground.Time -> List Playground.Shape
view time =
    [ rectangle brown 40 200
        |> rotate (spin 8 time)
    ]



-- Playground.Screen
-- : Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Screen


triangleEye : Program () Playground.Screen ( Int, Int )
triangleEye =
    picture
        [ triangle green 150
        , circle white 40
        , circle black 10
        ]


tree : Program () Playground.Screen ( Int, Int )
tree =
    picture
        [ rectangle brown 40 200
        , circle green 100
            |> moveUp 100
        ]
