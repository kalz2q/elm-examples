module HtmlStudy01 exposing (main)

import Html exposing (..)


main : Html msg
main =
    div []
        [ div []
            [ h1 [] [ text "山田太郎" ]
            , h2 [] [ text "君の名は。" ]
            , h3 [] [ text "花子と申します。" ]
            ]
        , br [][]
        , div []
            [ text "Hello, World!" ]
        ]
