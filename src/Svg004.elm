module Svg004 exposing (main)

-- This is how to fill, stroke, strokeWidth

import Html exposing (..)
import Svg
import Svg.Attributes as SA


main =
    div []
        [ Svg.svg
            [ SA.width "160"
            , SA.height "160"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "160"
                , SA.height "160"
                , SA.fill "skyblue"
                ]
                []
            , Svg.rect
                [ SA.x "20"
                , SA.y "20"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "#08c"
                ]
                []
            , Svg.rect
                [ SA.x "65"
                , SA.y "20"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "rgba(255, 0, 0, .4)"
                ]
                []
            , Svg.rect
                [ SA.x "110"
                , SA.y "20"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "hsla(120, 40%, 40%, .4)"
                ]
                []
            , Svg.rect
                [ SA.x "20"
                , SA.y "65"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "none"
                , SA.stroke "olive"
                , SA.strokeWidth "3"
                ]
                []
            , Svg.rect
                [ SA.x "65"
                , SA.y "65"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "none"
                , SA.stroke "olive"
                , SA.strokeWidth "3"
                , SA.strokeDasharray "10"
                ]
                []
            , Svg.rect
                [ SA.x "110"
                , SA.y "65"
                , SA.width "30"
                , SA.height "30"
                , SA.fill "none"
                , SA.stroke "olive"
                , SA.strokeWidth "3"
                , SA.strokeDasharray "10, 2"
                ]
                []
            ]
        ]
