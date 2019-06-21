module Bezier002 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "190", SA.height "300" ]
            [ Svg.path
                [ SA.d "M 10 80 C 40 10, 65 10, 95 80, S 150 150 , 180 80"
                , SA.stroke "black"
                , SA.fill "transparent"
                ]
                []
            ]
        ]
