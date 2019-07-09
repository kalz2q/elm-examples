module SvgClip exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "200", SA.height "200" ]
            [ Svg.defs []
                [ Svg.clipPath [ SA.id "cutOffBottom" ]
                    [ Svg.rect
                        [ SA.x "0"
                        , SA.y "0"
                        , SA.width "200"
                        , SA.height "100"
                        ]
                        []
                    ]
                ]
            , Svg.circle
                [ SA.cx "100"
                , SA.cy "100"
                , SA.r "100"
                -- , SA.ry "15"
                , SA.stroke "red"
                , SA.strokeWidth "3"
                , SA.clipPath "url(#cutOffBottom)"
                ]
                []
            ]
        ]
