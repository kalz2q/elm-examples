module Playground001 exposing (main)

import Playground exposing (..)


main =
    animation view2


view time =
    [ triangle orange 50
        |> rotate (spin 8 time)
    ]


view2 time =
    [ [ triangle green 150
      , circle white 40
      , circle black 10
      ]
        |> rotate (spin 8 time)
    ]


triangleEye =
    picture
        [ triangle green 150
        , circle white 40
        , circle black 10
        ]


tree =
    picture
        [ rectangle brown 40 200
        , circle green 100
            |> moveUp 100
        ]
