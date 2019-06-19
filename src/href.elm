module Href exposing (main)

import Html
import Html.Attributes as HA


main : Html.Html msg
main =
    Html.a
        [ HA.href "https://kalz2q.github.io/elm-examples/"
        , HA.style "background-color" "red"
        , HA.style "fontWeight" "bold"
        ]
        [ Html.text "go to examples" ]
