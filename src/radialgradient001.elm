module RadialGradient exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "120", SA.height "250" ]
            [ Svg.defs []
                [ Svg.radialGradient [ SA.id "RadialGradient1" ]
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
                , Svg.radialGradient [ SA.id "RadialGradient2"
                               , SA.cx "0.25"
                               , SA.cy "0.25"
                                ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "green"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "yellow"
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
                , SA.fill "url(#RadialGradient1)"
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
                , SA.fill "url(#RadialGradient2)"
                ]
                []
            ]
        ]
