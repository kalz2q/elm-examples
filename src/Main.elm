module Main exposing (main)

import Html exposing (Html, a, text, div, h1, ul, li)
import Html.Attributes exposing (href)


main : Html msg
main =
    div []
        [ h1 [] [ text "Useful Links" ]
        , ul []
            [ li [] [ a [ href "src/Counter.html" ] [ text "Counter" ] ]
            ]
        ]
