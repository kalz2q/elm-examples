module Svgtransf004 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "40"
            , SA.height "60"
            , SA.style "background-color: skyblue"
            , SA.fill "green"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "10"
                , SA.height "10"
                , SA.transform "translate(30,40) rotate (45) "
                ]
                []
            ]
        ]
