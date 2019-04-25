module Main exposing (viewAlt, viewChairAlts)

import Html exposing (..)


viewChairAlts : List String -> Html msg
viewChairAlts chairAlts = \
    div [] \
        [ p [] [ text "Chair alternatives include:" ] \
        , ul [] (List.map viewAlt chairAlts) \
        ] \


viewAlt : String -> Html msg
viewAlt chairAlt = \
    li [] [ text chairAlt ] \
