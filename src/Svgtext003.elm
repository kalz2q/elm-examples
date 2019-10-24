module SvgText003 exposing (main)

-- th is do not work

import Html
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main =
    Html.div [ HA.style "textAlign" "center" ]
        [ Svg.svg [ SA.width "400", SA.height "300" ]
            [ Svg.path
                [ SA.id "my_path"
                , SA.d "M 20, 20 C 80, 60 100 , 40 120, 20"
                , SA.fill "black"
                ]
                [Svg.text "this"]
            , Svg.text_
                [ SA.xlinkHref "url(#my_path)"
                ]
                [ Svg.text "A curve. "
                ]
            ]
        ]
