module SvgText002 exposing (main)

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "400", SA.height "300" ]
            [ Svg.text_
                [ SA.x "38"
                , SA.y "40"
                , SA.fontFamily "sans-serif"
                , SA.fontSize "12pt"
                ]
                [ Svg.text "This is "
                , Svg.tspan
                    [ SA.fill "red"
                    , SA.fontWeight "bold"
                    ]
                    [ Svg.text "bold and red." ]
                ]
            ]
        ]
