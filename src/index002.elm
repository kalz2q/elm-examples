module Index002 exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, a, div, h1, li, p, ul)


main : Html msg
main =
    layout [ Font.family [ Font.typeface "Noto Serif CJK JP" ] ] <|
        column
            [ width (px 600)
            , height (px 400)
            , Background.color lightpink
            , centerX
            , spacing 10
            ]
            [ firstColumn
            , listOfExamples
            ]


firstColumn =
    column [ spacing 10, Font.size 14, centerX]
        [ el [ Font.size 30, Font.bold, centerX ] <| text "Links to Examples"
        , el [centerX] <| text "I am learning Elm 0.19."
        , el [centerX] <| text "Source files are availabel at "
        , link [centerX]
            { url = "https://github.com/kalz2q/elm-examples"
            , label = text "https://github.com/kalz2q/elm-examples"
            }
        , el [centerX] <| text "コピペしたり試行錯誤してElmで作ったもののリストです。"
        , el [] <| text ""
        ]


listOfExamples =
    column [spacing 10]
        [ el [] <| text "リスト"
        , row []
            [ text "・"
            , link []
                { url = "random001.html"
                , label = text ("random001.html => random number 発生機")
                }
            ]
        , row []
            [ text "・"
            , link []
                { url = "time002.html"
                , label = text ("time002.html => デジタル時計")
                }
            ]
        , row []
            [ text "・"
            , link []
                { url = "holyg002.html"
                , label = text ("holyg002.html => 色付き聖杯")
                }
            ]
        , row []
            [ text "・"
            , link []
                { url = "hello006.html"
                , label = text ("hello006.html => 色付きハローワールドセンタリング")
                }
            ]
         , row []
            [ text "・"
            , link []
                { url = "bluebox002.html"
                , label = text ("bluebox002.html => 青の研究")
                }
            ]
         , row []
            [ text "・"
            , link []
                { url = "bluebox001.html"
                , label = text ("bluebox001.html => 青い正方形を上下センタリング")
                }
            ]
         , row []
            [ text "・"
            , link []
                { url = "hello001.html"
                , label = text ("hello001.html => 一番簡単な hello world")
                }
            ]
        ]

lightpink = rgb255 255 182 193