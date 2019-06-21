module Bezier003 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "300", SA.height "300" ]
            [ Svg.path
                [ SA.d "M 10 80 Q 95 10 180 80"
                , SA.stroke "black"
                , SA.fill "transparent"
                ]
                []
            , Svg.path
                [ SA.d "M 10 180 Q 52.5 110 95 180 T 180 180  265 180 , 350 180"
                , SA.stroke "black"
                , SA.fill "transparent"
                ]
                []
            ]
        ]
