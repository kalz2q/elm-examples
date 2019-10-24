module HelloWorldWithCSS exposing (main, stylesheet)

import Html exposing (Html, div, text, node)
import Html.Attributes exposing (..)


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "styles.css"
            ]

        children =
            []
    in
    node tag attrs children


main : Html msg
main =
    div [id "container"] [ stylesheet,  text "ハロー、CSS" ]