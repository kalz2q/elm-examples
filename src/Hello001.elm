module Hello001 exposing (main)

-- write hello world without using browser.sandbox => Hello001

import Html exposing (..)
import Html.Attributes as HA


main : Html msg
main =
    div
        [ HA.style "color" "blue"
        , HA.style "font-size" "200%"
        ]
        [ Html.text "hello world" ]
