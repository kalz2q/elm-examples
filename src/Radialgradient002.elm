module RadialGradient002 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "220", SA.height "220" ]
            [ Svg.defs []
                [ Svg.radialGradient
                    [ SA.id "GradientPad"
                    , SA.cx "0.5"
                    , SA.cy "0.5"
                    , SA.r "0.4"
                    , SA.fx "0.75"
                    , SA.fy "0.75"
                    , SA.spreadMethod "pad"
                    ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "blue"
                        ]
                        []
                    ]
                , Svg.radialGradient
                    [ SA.id "GradientRepeat"
                    , SA.cx "0.5"
                    , SA.cy "0.5"
                    , SA.r "0.4"
                    , SA.fx "0.75"
                    , SA.fy "0.75"
                    , SA.spreadMethod "repeat"
                    ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "blue"
                        ]
                        []
                    ]
                , Svg.radialGradient
                    [ SA.id "GradientReflect"
                    , SA.cx "0.5"
                    , SA.cy "0.5"
                    , SA.r "0.4"
                    , SA.fx "0.75"
                    , SA.fy "0.75"
                    , SA.spreadMethod "reflect"
                    ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "blue"
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
                , SA.fill "url(#GradientPad)"
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
                , SA.fill "url(#GradientRepeat)"
                ]
                []
            , Svg.rect
                [ SA.x "120"
                , SA.y "120"
                , SA.rx "15"
                , SA.ry "15"
                , SA.width "100"
                , SA.height "100"
                , SA.stroke "black"
                , SA.strokeWidth "3"
                , SA.fill "url(#GradientReflect)"
                ]
                []
            , Svg.text_
                [ SA.x "15"
                , SA.y "30"
                , SA.fill "white"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "12pt"
                ]
                [ Svg.text "Pad" ]
            , Svg.text_
                [ SA.x "15"
                , SA.y "140"
                , SA.fill "white"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "12pt"
                ]
                [ Svg.text "Repeat" ]
            , Svg.text_
                [ SA.x "125"
                , SA.y "140"
                , SA.fill "white"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "12pt"
                ]
                [ Svg.text "Reflect" ]

            ]
        ]
