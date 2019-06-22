module Arc002 exposing (main)

import Html
import Svg
import Svg.Attributes as SA


main =
    Html.div []
        [ Svg.svg [ SA.width "320", SA.height "320" ]
            [ Svg.path
                [ SA.d "M 10 315 L 110 215  A 36 60 0 0 1 150.71 170.29 L 172.55 152.45   A 30 50 -45 0 1 215.1 109.9 L 315 10"
                , SA.stroke "black"
                , SA.fill "green"
                , SA.strokeWidth "2"
                , SA.fillOpacity "0.5"
                ]
                []
            , Svg.circle
                [ SA.cx "150.71"
                , SA.cy "170.29"
                , SA.r "10"
                , SA.fill "red"
                ]
                []
            , Svg.circle
                [ SA.cx "110"
                , SA.cy "215"
                , SA.r "10"
                , SA.fill "red"
                ]
                []
            , Svg.ellipse [ SA.cx "144.931", SA.cy "229.512", SA.rx "36", SA.ry "60", SA.fill "transparent", SA.stroke "blue" ] []
            , Svg.ellipse [ SA.cx "115.779", SA.cy "155.778", SA.rx "36", SA.ry "60", SA.fill "transparent", SA.stroke "blue" ] []
            ]
        ]
