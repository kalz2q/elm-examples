module Svg003 exposing (main)

-- this is from mdn

import Html
import Svg
import Svg.Attributes as SA


main =
    Svg.svg
        [ SA.viewBox "0 0 300 100"
        , SA.stroke "red"
        , SA.fill "grey"
        ]
        [ Svg.circle
            [ SA.cx "50"
            , SA.cy "50"
            , SA.r "40"
            ]
            []
        , Svg.circle
            [ SA.cx "50"
            , SA.cy "50"
            , SA.r "4"
            ]
            []
        ]
