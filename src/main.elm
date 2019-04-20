module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ h1 [ style "font-family" "serif" ] [ text "Links to Samples" ]
        , p [] []
        , ul []
            [ li [] [ a [ href "src/httpgutenberg.html" ] [ text "httpグーテンベルグ" ] ]
            , li [] [ a [ href "src/jsoncats.html" ] [ text "jsonによる猫動画" ] ]
            , li [] [ a [ href "src/randomnumber.html" ] [ text "randomサイコロ" ] ]
            , li [] [ a [ href "src/timenow.html" ] [ text "time今何時?" ] ]
            , li [] [ a [ href "src/maybetemperature.html" ] [ text "Maybe華氏何度?" ] ]
            , li [] [ a [ href "src/passwordmatch.html" ] [ text "パスワードマッチ" ] ]
            , li [] [ a [ href "src/fieldtoreverse.html" ] [ text "テキストフィールドのサンプル" ] ]
            , li [] [ a [ href "src/httpgetrepository.html" ] [ text "Httpのサンプル" ] ]
            , li [] [ a [ href "src/textformlist.html" ] [ text "Form" ] ]
            , li [] [ a [ href "src/counter.html" ] [ text "Counter" ] ]
            ]
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP" ] [ text "コピペしたり試行錯誤してElmから作ったもののリストです。ソースは以下をご覧ください。" ]
        , a [ href "https://github.com/kalz2q/elm-projects" ] [ text "https://github.com/kalz2q/elm-projects" ]
        ]
