module Svg003 exposing (main)

-- this is from mdn

import Html exposing (..)
import Svg
import Svg.Attributes as SA


main : Html msg
main =
    Svg.svg
        [ SA.viewBox "0 0 400 400"
        , SA.stroke "red"
        , SA.fill "grey"
        ]
        [ circleSvg1
        , circleSvg2
        ]


circleSvg1 : Html msg
circleSvg1 =
    Svg.circle
        [ SA.cx "50"
        , SA.cy "50"
        , SA.r "40"
        , SA.fill "green"
        ]
        []


circleSvg2 =
    Svg.circle
        [ SA.cx "50"
        , SA.cy "50"
        , SA.r "4"
        ]
        []
