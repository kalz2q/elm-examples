module SvgTrasF001 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "30"
            , SA.height "10"
            , SA.fill "red"
            ]
            [ Svg.rect
                [ SA.x "0"
                , SA.y "0"
                , SA.width "10"
                , SA.height "10"
                ]
                []
            , Svg.rect
                [ SA.x "20"
                , SA.y "0"
                , SA.width "10"
                , SA.height "10"
                ]
                []
            ]
        ]
