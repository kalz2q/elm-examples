module BlueBox001 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)



-- draw a blue box , skyblue, centering


main =
    layout [] <|
        column
            [ width <| px 100
            , height <| px 100
            , centerX
            , centerY
            , Background.color skyblue
            ]
            [ row
                [ centerX, centerY ]
                [ text "skyblue" ]
            ]


skyblue =
    rgb255 135 206 235
