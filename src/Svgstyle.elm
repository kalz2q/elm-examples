module Svgstyle exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.rect
                [ SA.x "10"
                , SA.height "180"
                , SA.y "10"
                , SA.width "180"
                , SA.stroke "black"
                , SA.style "fill:red; stroke-width: 3; stroke :green"
                ]
                []
            ]
        ]
