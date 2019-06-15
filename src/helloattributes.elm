module HelloAttributes exposing (main)

import Html
import Html.Attributes as HA


main =
    Html.div
        [ HA.style "background-color" "yellow"
        , HA.style "width" "600px"
        , HA.style "height" "400px"
        , HA.style "margin" "auto"
        , HA.style "position" "relative"
        ]
        [ Html.h1
            [ HA.style "width" "200px"
            , HA.style "height" "100px"
            , HA.style "color" "red"
            , HA.style "background-color" "lightgreen"
            , HA.style "text-align" "center"
            , HA.style "position" "absolute"
            , HA.style "top" "50%"
            , HA.style "left" "50%"
            , HA.style "transform" "translate(-50%, -50%)"
            ]
            [ Html.text "Hello, world!"
            ]
        ]
