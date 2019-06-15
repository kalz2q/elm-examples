module Hello001 exposing (main)

import Html
import Html.Attributes as HA


main =
    Html.div
        [ HA.style "color" "red"
        , HA.style "font-size" "200%"
        ]
        [ Html.text "hello world" ]
