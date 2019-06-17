module SvgMdn001 exposing (main)

import Svg
import Svg.Attributes as SA


main =
    Svg.svg
        [ SA.version "1.1"
        , SA.baseProfile "full"
        , SA.width "300"
        , SA.height "200"
        , SA.fill "skyblue"
        ]
        [ Svg.rect
            [ SA.width "100%"
            , SA.height "100%"
            , SA.fill "tomato"
            ]
            []
        , Svg.circle
            [ SA.cx "150"
            , SA.cy "100"
            , SA.r "80"
            , SA.fill "lightgreen"
            ]
            []
        , Svg.text_
            [ SA.x "150"
            , SA.y "125"
            , SA.fontSize "60"
            , SA.textAnchor "middle"
            , SA.fill "white"
            ]
            [ Svg.text "SVG" ]
        ]
