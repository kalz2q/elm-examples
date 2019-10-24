module BlueBox003 exposing (main)

-- draw a blue box , text skyblue, centering x , y

import Html
import Html.Attributes as HA


main =
    Html.div
        [ HA.style "width" "100px"
        , HA.style "height" "100px"
        , HA.style "position" "absolute"
        , HA.style "top" "50%"
        , HA.style "left" "50%"
        , HA.style "transform" "translate(-50%, -50%)"
        , HA.style "background-color" "skyblue"
        ]
        [ Html.div
            [ HA.style "position" "absolute"
            , HA.style "top" "50%"
            , HA.style "left" "50%"
            , HA.style "transform" "translate(-50%, -50%)"
            , HA.style "background-color" "yellow"
            ]
            [ Html.text "skyblue" ]
        ]
