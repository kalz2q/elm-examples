module Hello004 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)



-- rowを使ってみる



main =
    layout [] <|
        row [Background.color (rgb255 200 200 200)
        , width fill
        , centerX]
            [ el [width <| fillPortion 3]
                (text "hello world")
            , el [width <| fillPortion 4] (text "hellooooo woooorld")
            , el [width <| fillPortion 5] (text "whats up? wwwwwwwwwwwwww")
            ]
