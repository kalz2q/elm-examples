module Audio003 exposing (main)

import Html exposing (..)
import Html.Attributes as HA


main =
    audio
        [ HA.src "../foo.wav"
        , HA.controls True
        ]
        []
