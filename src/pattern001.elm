module Pattern001 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.defs []
                [ Svg.linearGradient [ SA.id "Gradient1" ]
                    [ Svg.stop
                        [ SA.offset "5%"
                        , SA.stopColor "white"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "95%"
                        , SA.stopColor "blue"
                        ]
                        []
                    ]
                , Svg.linearGradient
                    [ SA.id "Gradient2"
                    , SA.x1 "0"
                    , SA.x2 "0"
                    , SA.y1 "0"
                    , SA.y2 "1"
                    ]
                    [ Svg.stop
                        [ SA.offset "5%"
                        , SA.stopColor "red"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "95%"
                        , SA.stopColor "orange"
                        ]
                        []
                    ]
                , Svg.pattern
                    [ SA.id "Pattern"
                    , SA.x "0"
                    , SA.y "0"
                    , SA.width ".25"
                    , SA.height ".25"
                    ]
                    [ Svg.rect
                        [ SA.x "0"
                        , SA.y "0"
                        , SA.width "50"
                        , SA.height "50"
                        , SA.fill "skyblue"
                        ]
                        []
                    , Svg.rect
                        [ SA.x "0"
                        , SA.y "0"
                        , SA.width "25"
                        , SA.height "25"
                        , SA.fill "url(#Gradient2)"
                        ]
                        []
                    , Svg.circle
                        [ SA.cx "25"
                        , SA.cy "25"
                        , SA.r "20"
                        , SA.fill "url(#Gradient1)"
                        , SA.fillOpacity "0.5"
                        ]
                        []
                    ]
                ]
            , Svg.rect
                [ SA.fill "url(#Pattern)"
                , SA.stroke "black"
                , SA.width "200"
                , SA.height "200"
                ]
                []
            ]
        ]
