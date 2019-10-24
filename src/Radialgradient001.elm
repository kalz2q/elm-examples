module RadialGradient001 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "120", SA.height "300" ]
            [ Svg.defs []
                [ Svg.radialGradient
                    [ SA.id "RadialGradient"
                    , SA.cx "0.5"
                    , SA.cy "0.5"
                    , SA.r "0.5"
                    , SA.fx "0.25"
                    , SA.fy "0.25"
                    ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "lightblue"
                        ]
                        []
                    ]
                ]
            , Svg.rect
                [ SA.x "10"
                , SA.y "10"
                , SA.rx "15"
                , SA.ry "15"
                , SA.width "100"
                , SA.height "100"
                , SA.stroke "black"
                , SA.strokeWidth "3"
                , SA.fill "url(#RadialGradient)"
                ]
                []
            , Svg.rect
                [ SA.x "10"
                , SA.y "120"
                , SA.rx "15"
                , SA.ry "15"
                , SA.width "100"
                , SA.height "100"
                , SA.stroke "black"
                , SA.strokeWidth "3"
                , SA.fill "url(#RadialGradient)"
                ]
                []
            , Svg.circle
                [ SA.cx "60"
                , SA.cy "60"
                , SA.r "50"
                , SA.fill "transparent"
                , SA.stroke "white"
                , SA.strokeWidth "3"
                ]
                []
            , Svg.circle
                [ SA.cx "35"
                , SA.cy "35"
                , SA.r "2"
                , SA.fill "white"
                , SA.stroke "white"
                , SA.strokeWidth "2"
                ]
                []
            , Svg.circle
                [ SA.cx "60"
                , SA.cy "60"
                , SA.r "2"
                , SA.fill "white"
                , SA.stroke "white"
                , SA.strokeWidth "2"
                ]
                []
            , Svg.text_
                [ SA.x "38"
                , SA.y "40"
                , SA.fill "white"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "10pt"
                ]
                [ Svg.text "(fx, fy)" ]
            , Svg.text_
                [ SA.x "63"
                , SA.y "63"
                , SA.fill "white"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "10pt"
                ]
                [ Svg.text "(cx, fcy)" ]
            ]
        ]
