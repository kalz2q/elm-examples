module MyElmProjects exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ h1 [ style "font-family" "serif" ] [ text "Links to Examples" ]
        , p [] [ text "I am learning Elm 0.19." ]
        , p [] [ text "All the elm source files are availabel at " ]
        , p [] [ a [ href "https://github.com/kalz2q/elm-projects" ] [ text "https://github.com/kalz2q/elm-projects" ] ]
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP" ] [ text "コピペしたり試行錯誤してElmから作ったもののリストです。" ]
        , ul []
            [ li [] [ a [ href "src/helloworld01.html" ] [ text "一番簡単なElmによるハローワールド" ] ]
            , li [] [ a [ href "src/externalcss02.html" ] [ text "cssの組み込み実験" ] ]
            , li [] [ a [ href "src/httpgutenberg.html" ] [ text "httpグーテンベルグ" ] ]
            , li [] [ a [ href "src/jsoncats.html" ] [ text "jsonによる猫動画" ] ]
            , li [] [ a [ href "src/randomnumber.html" ] [ text "randomサイコロ" ] ]
            , li [] [ a [ href "src/timenow.html" ] [ text "time今何時?" ] ]
            , li [] [ a [ href "src/maybetemperature.html" ] [ text "Maybe華氏何度?" ] ]
            , li [] [ a [ href "src/passwordmatch.html" ] [ text "パスワードマッチ" ] ]
            , li [] [ a [ href "src/fieldtoreverse.html" ] [ text "テキストフィールドのサンプル" ] ]
            , li [] [ a [ href "src/httpgetrepository.html" ] [ text "Httpのサンプル" ] ]
            , li [] [ a [ href "src/textformlist.html" ] [ text "Formテキスト入力" ] ]
            , li [] [ a [ href "src/counter.html" ] [ text "Counter.html" ] ]
            ]
        ]
