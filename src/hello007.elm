module Hello007 exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


main =
    layout [] <|
        row
            [ Background.color <| rgb255 200 169 85
            , width <| px 400
            , height <| px 400
            ]
            [ row
                [ Background.color <| rgb255 255 169 85
                , width fill
                , height <| px 240
                , centerX
                ]
                [ el [ centerX, centerY ] <| text "Hello, world" ]
            ]
