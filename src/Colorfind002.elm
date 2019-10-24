module ColorFind001 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Html


main =
    layout [] <|
        wrappedRow
            [ spacing 20
            , padding 10
            , Background.color lightpink
            ]
            [ row [ width <| px 150, height <| px 150, Background.color lightgoldenrodyellow ] [ text "this1" ]
            , row [ width <| px 150, height <| px 150, Background.color lightgreen ] [ text "that2" ]
            ]

