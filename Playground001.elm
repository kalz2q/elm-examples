module Playground001 exposing (main)

import Playground exposing (..)


main =
    picture
        [ rectangle brown 40 200
        , circle green 40
            |> moveUp 500
        ]
