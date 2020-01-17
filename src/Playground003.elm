module Playground003 exposing (main, tree, triangleEye, view)

import Playground exposing (..)


main : Program () Playground.Screen ( Int, Int )
main =
    triangleEye


view : Playground.Time -> List Playground.Shape
view time =
    [ rotate (spin 10 time) <| rectangle brown 40 200
    ]



-- Playground.Screen
-- : Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Number
--   -> Playground.Screen

-- Playground.picture
--     : List Playground.Shape -> Program () Playground.Screen ( Int, Int )


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
