module Misc001 exposing (main)

-- there's no way to show information on type of variable because elm does not know the type when runtime
-- type is checked before compilation

import Html
import Html.Attributes as HA



main =
    Html.div
        [ HA.style "background-color" "gainsboro"
        , HA.style "width" "600px"
        , HA.style "margin" "auto"
        , HA.style "position" "relative"
        ]
        [ Html.h1 [ HA.style "text-align" "center" ] [ Html.text "Miscellaneous Facts in Elm" ]
        , Html.ol []
            [ Html.li [] [ Html.text ("trueInElm is :" ++ (if trueInElm then "True" else "False"))]
            ]
        ]

trueInElm = True

meaningOfLife : Int
meaningOfLife = 68

