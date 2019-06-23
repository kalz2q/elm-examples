module StrokeLinejoin exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA



--   <line x1="40" x2="120" y1="60" y2="60" stroke="black" stroke-width="20" stroke-linecap="square"/>
--   <line x1="40" x2="120" y1="100" y2="100" stroke="black" stroke-width="20" stroke-linecap="round"/>
-- </svg>


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "160"
            , SA.height "280"
            ]
            [ Svg.polyline
                [ SA.points "40 60 80 20 120 60"
                , SA.stroke "orange"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "butt"
                , SA.fill "none"
                , SA.strokeLinejoin "miter"
                ]
                []
            , Svg.polyline
                [ SA.points "40 140 80 100 120 140"
                , SA.stroke "black"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "square"
                , SA.fill "none"
                , SA.strokeLinejoin "round"
                ]
                []
            , Svg.polyline
                [ SA.points "40 220 80 180 120 220"
                , SA.stroke "green"
                , SA.strokeWidth "20"
                , SA.strokeLinecap "round"
                , SA.fill "none"
                , SA.strokeLinejoin "bevel"
                ]
                []
            ]
        ]
