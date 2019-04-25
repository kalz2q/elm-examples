module Main exposing (main, stylesheet)

import Html exposing (Html, div, text, node)
import Html.Attributes exposing (..)


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://kalz2q.github.io/elm-projects/css/styles.css"
            ]

        children =
            []
    in
    node tag attrs children


main : Html msg
main =
    Html.div [] [ stylesheet,  Html.text "Heeello, World!" ]
