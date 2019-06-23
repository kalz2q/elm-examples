module FillStroke exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg []
            [ Svg.rect
                [ SA.x "10"
                , SA.y "10"
                , SA.width "100"
                , SA.height "100"
                , SA.stroke "blue"
                , SA.strokeWidth "3"
                , SA.fill "purple"
                , SA.fillOpacity "0.5"
                , SA.strokeOpacity "0.8"
                ]
                []
            ]
        ]
