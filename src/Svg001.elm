module Svg001 exposing (main)

-- learning svg and viewport
-- msn , dotinstall, etc.
-- cf. SA.preserveAspectRatio "none"

import Html exposing (..)
import Html.Attributes as HA
import Svg
import Svg.Attributes as SA


main : Html msg
main =
    div [ HA.style "text-align" "center" ]
        [ Svg.svg
            [ SA.width "400" -- viewport
            , SA.height "400"
            , SA.viewBox "0 0 200 200"
            , SA.style "background:#38a"
            ]
            [ Svg.circle
                [ SA.cx "50"
                , SA.cy "50"
                , SA.r "50"
                , SA.fill "blue"
                ]
                []
            ]
        ]
