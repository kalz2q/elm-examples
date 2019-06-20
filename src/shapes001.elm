-- module Shapes001 exposing (main)


module Main exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "200", SA.height "250" ]
            [ Svg.path
                [ SA.d "M20,230 Q40,205 50,230 T90,230"
                , SA.stroke "blue"
                , SA.fill "none"
                , SA.strokeWidth "5"
                ]
                []
            ]
        , Svg.svg [ SA.width "200", SA.height "250" ]
            [ Svg.polyline
                [ SA.points "20,230 40,205 50,230 90,230"
                , SA.stroke "orange"
                , SA.fill "none"
                , SA.strokeWidth "5"
                ]
                []
            ]
        ]
