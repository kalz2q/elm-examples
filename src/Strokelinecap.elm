module StrokeLinecap exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA



main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "160"
            , SA.height "140"
            ]
            [ Svg.line
                [ SA.x1 "40"
                , SA.x2 "120"
                , SA.y1 "20"
                , SA.y2 "20"
                , SA.stroke "orange"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "butt"
                ]
                []
            , Svg.line
                [ SA.x1 "40"
                , SA.x2 "120"
                , SA.y1 "60"
                , SA.y2 "60"
                , SA.stroke "black"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "square"
                ]
                []
            , Svg.line
                [ SA.x1 "40"
                , SA.x2 "120"
                , SA.y1 "100"
                , SA.y2 "100"
                , SA.stroke "green"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "round"
                ]
                []
            ]
        ]
