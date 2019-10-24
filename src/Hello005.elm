module Hello005 exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Html exposing (Html)



-- rowを使ってみる
-- columnと両方使う
-- hello005.elm


main =
    layout [] <|
        column [width fill]
            [ row [ width fill ]
                [ el
                    [ Background.color (rgb255 200 200 200)
                    , width (fillPortion 3)
                    ]
                    (text "hello")
                , el [ width (fillPortion 3) ] (text "hello")
                , el [] (text "word")
                ]
            , row [ width fill ]
                [ el
                    [ width (fillPortion 3)
                    ]
                    (text "hello")
                , el [ width (fillPortion 3) ] (text "hello")
                , el [] (text "word")
                ]
            , row [ width fill ]
                [ el
                    [ Background.color (rgb255 200 200 200)
                    , width (fillPortion 3)
                    ]
                    (text "hello")
                , el [ width (fillPortion 3) ] (text "hello")
                , el [] (text "word")
                ]
            ]
