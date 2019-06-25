module LinearGradient exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "120", SA.height "250" ]
            [ Svg.defs []
                [ Svg.linearGradient [ SA.id "Gradient1" ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "50%"
                        , SA.stopColor "black"
                        , SA.stopOpacity "0"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "100%"
                        , SA.stopColor "blue"
                        ]
                        []
                    ]
                , Svg.linearGradient [ SA.id "Gradient2"
                               , SA.x1 "0"
                               , SA.x2 "0"
                               , SA.y1 "0"
                               , SA.y2 "1" ]
                    [ Svg.stop
                        [ SA.offset "0%"
                        , SA.stopColor "green"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "50%"
                        , SA.stopColor "black"
                        , SA.stopOpacity "0"
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
                , SA.fill "url(#Gradient1)"
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
                , SA.fill "url(#Gradient2)"
                ]
                []
            ]
        ]
