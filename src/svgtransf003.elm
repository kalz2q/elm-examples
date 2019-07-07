module SvgTrasF003 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg
            [ SA.width "31"
            , SA.height "31"
            , SA.style "background-color: orange"
            , SA.fill "green"
            ]
            [ Svg.rect
                [ SA.x "12"
                , SA.y "-10"
                , SA.width "20"
                , SA.height "20"
                , SA.transform "rotate (45) "
                ]
                []
            ]
        ]
