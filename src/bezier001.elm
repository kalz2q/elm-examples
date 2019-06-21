module Bezier001 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [SA.width "190", SA.height "300"  ]
            [ Svg.path
                [ SA.d "M 10 10 C 20 20, 40 20, 50 10" 
                , SA.stroke "black" 
                , SA.fill "transparent"
                ]
                []
            , Svg.path
                [ SA.d "M20,230 Q40,205 50,230 T90,230"
                , SA.stroke "blue"
                , SA.fill "none"
                , SA.strokeWidth "5"
                ]
                []
            ]
        ]

