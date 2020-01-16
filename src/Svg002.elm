module Svg002 exposing (main)

-- This is how to use viewBox
-- from dotinstall

import Html exposing (..)
import Svg
import Svg.Attributes as SA


main =
    div []
        [ Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "0 0 160 160"
            ]
            rectSvg
        , Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "0 0 320 320"
            ]
            rectSvg
        , Svg.svg
            [ SA.width "160"
            , SA.height "160"
            , SA.viewBox "40 40 80 80"
            ]
            rectSvg
        ]


rectSvg =
    [ Svg.rect
        [ SA.x "0"
        , SA.y "0"
        , SA.width "160"
        , SA.height "160"
        , SA.fill "skyblue"
        ]
        []
    , Svg.rect
        [ SA.x "40"
        , SA.y "40"
        , SA.width "80"
        , SA.height "80"
        , SA.fill "tomato"
        ]
        []
    ]
