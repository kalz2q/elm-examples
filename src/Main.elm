module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ h1 [style "font-family" "serif"] [ text "Links to Samples" ]
        , p [] []
        , ul []
            [ li [] [ a [ href "src/Counter.html" ] [ text "Counter" ] ]
            , li [] [ a [ href "src/Form.html"] [ text "Form"]]
            ]
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP" ] [ text "コピペしたり試行錯誤してElmから作ったもののリストです。ソースは以下をご覧ください。" ]
        , a [ href "https://github.com/kalz2q/elm-projects" ] [ text "https://github.com/kalz2q/elm-projects" ]
        ]
