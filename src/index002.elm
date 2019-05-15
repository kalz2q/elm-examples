module MyElmProjects exposing (main)

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
            [ width (px 400)
            , height (px 400)
            , Background.color (rgb255 200 180 170)
            , centerX
            , Font.size 14
            , spacing 10
            ]
            [ el [ Font.size 30, Font.bold ] <| text "Links to Examples"
            , el [] <| text "I am learning Elm 0.19."
            , row [] 
              [ text "All the elm source files are availabel at "
              , link []
                { url = "https://github.com/kalz2q/elm-projects"
                , label = text "https://github.com/kalz2q/elm-projects"
                }
              ]
            , el [] <| text "コピペしたり試行錯誤してElmから作ったもののリストです。"
            , row []
                [ text "・"
                , link []
                    { url = "src/time002.html"
                    , label = text "時計"
                    }
                , row []
                    [ text "・"
                    , link []
                        { url = "src/hello007.html"
                        , label = text "ハローワールド"
                        }
                    ]
                ]
            ]
