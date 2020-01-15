module Svgmask exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.defs []
                [ Svg.linearGradient [ SA.id "Gradient" ]
                    [ Svg.stop
                        [ SA.offset "0"
                        , SA.stopColor "white"
                        , SA.stopOpacity "0"
                        ]
                        []
                    , Svg.stop
                        [ SA.offset "1"
                        , SA.stopColor "white"
                        , SA.stopOpacity "1"
                        ]
                        []
                    ]
                , Svg.mask [ SA.id "Mask" ]
                    [ Svg.rect
                        [ SA.x "0"
                        , SA.y "0"
                        , SA.width "200"
                        , SA.height "200"
                        , SA.fill "url(#Gradient)"
                        ]
                        []
                    ]
                ]
            , Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "200"
                , SA.height "200"
                , SA.fill "green"
                ]
                []
            , Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "200"
                , SA.height "200"
                , SA.fill "red"
                , SA.mask "url(#Mask)"
                ]
                []
            ]
        ]
