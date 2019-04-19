module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ h1 [] [ text "Links to Samples" ]
        , p [] []
        , ul []
            [ li [] [ a [ href "src/Counter.html" ] [ text "Counter" ] ]
            ]
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP" ] [ text "コピペしたり試行錯誤してElmファイルから作ったもののリストです。ソースファイルは以下をご覧ください。" ]
        , a [ href "https://github.com/kalz2q/elm-projects" ] [ text "https://github.com/kalz2q/elm-projects" ]
        ]
