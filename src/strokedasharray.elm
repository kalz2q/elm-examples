module StrokeDasharray exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "150" ]
            [ Svg.path
                [ SA.d "M 10 75 Q 50 10 100 75 T 190 75"
                , SA.stroke "black"
                , SA.strokeLinecap "round"
                , SA.strokeWidth "2"
                , SA.strokeDasharray "5,10,5"
                , SA.fill "none"
                ]
                []
            , Svg.path
                [ SA.d "M 10 75 L 190 75"
                , SA.stroke "red"
                , SA.strokeLinecap "round"
                , SA.strokeWidth "2"
                , SA.strokeDasharray "5,5"
                , SA.fill "none"
                ]
                []
            ]
        ]
