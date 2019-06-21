module Shapes exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "200", SA.height "250" ]
            [ Svg.rect [ SA.x "10", SA.y "10", SA.width "30", SA.height "30", SA.stroke "black", SA.fill "transparent", SA.strokeWidth "5" ] []
            , Svg.rect
                [ SA.x "60"
                , SA.y "10"
                , SA.rx "10"
                , SA.ry "10"
                , SA.width "30"
                , SA.height "30"
                , SA.stroke "olive"
                , SA.fill "pink"
                , SA.strokeWidth "7"
                ]
                []
            , Svg.circle
                [ SA.cx "25"
                , SA.cy "75"
                , SA.r "20"
                , SA.stroke "red"
                , SA.fill "skyblue"
                , SA.strokeWidth "5"
                ]
                []
            , Svg.ellipse
                [ SA.cx "75"
                , SA.cy "75"
                , SA.rx "20"
                , SA.ry "5"
                , SA.stroke "red"
                , SA.fill "skyblue"
                , SA.strokeWidth "5"
                ]
                []
            , Svg.line
                [ SA.x1 "10"
                , SA.x2 "59"
                , SA.y1 "110"
                , SA.y2 "150"
                , SA.stroke "orange"
                , SA.strokeWidth "5"
                ]
                []
            , Svg.polyline
                [ SA.points "60 110 65 120 70 115 75 130 80 125 85 140 90 135 95 150 100 145"
                , SA.stroke "orange"
                , SA.fill "beige"
                , SA.strokeWidth "5"
                ]
                []
            , Svg.polygon
                [ SA.points "50 160 55 180 70 180 60 190 65 205 50 195 35 205 40 190 30 180 45 180"
                , SA.stroke "green"
                , SA.fill "beige"
                , SA.strokeWidth "5"
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

