module Svg001 exposing (..)

import Svg
import Svg.Attributes as SA


main =
    Svg.svg
        [ SA.width "120"
        , SA.height "120"
        , SA.viewBox "0 0 400 120"
        , SA.fill "skyblue"
        ]
        [ Svg.rect
            [ SA.x "10"
            , SA.y "10"
            , SA.width "100"
            , SA.height "100"
            , SA.rx "15"
            , SA.ry "15"
            ]
            []
        , Svg.circle
            [ SA.cx "50"
            , SA.cy "50"
            , SA.r "50"
            ]
            []
        ]
