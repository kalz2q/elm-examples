module MyElmProjects exposing (main)

import Html exposing (Html,a, h1, li, ul, p, div)
import Html.Attributes exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input

main : Html msg
main =
    div []
        [ h1 [ style "font-family" "serif" ] [ Html.text "Links to Examples" ]
        , p [] [ Html.text "I am learning Elm 0.19." ]
        , p [] [ Html.text "All the elm source files are availabel at " ]
        , p [] [ a [ href "https://github.com/kalz2q/elm-projects" ] [ Html.text "https://github.com/kalz2q/elm-projects" ] ]
        , p [ style "font-size" "30px", style "font-family" "Noto Serif CJK JP" ] [ Html.text "コピペしたり試行錯誤してElmから作ったもののリストです。" ]
        , ul []
            [ li [] [ a [ href "src/helloworldattribute.html" ] [ Html.text "attribute付きハローワールド" ] ]
            , li [] [ a [ href "src/helloworlddiv.html" ] [ Html.text "div付きハローワールド" ] ]
            , li [] [ a [ href "src/helloworldtype.html" ] [ Html.text "型付きハローワールド" ] ]
            , li [] [ a [ href "src/helloworld01.html" ] [ Html.text "一番簡単なElmによるハローワールド" ] ]
            , li [] [ a [ href "src/helloworldcss.html" ] [ Html.text "cssの組み込み実験" ] ]
            , li [] [ a [ href "src/httpgutenberg.html" ] [ Html.text "httpグーテンベルグ" ] ]
            , li [] [ a [ href "src/jsoncats.html" ] [ Html.text "jsonによる猫動画" ] ]
            , li [] [ a [ href "src/randomnumber.html" ] [ Html.text "randomサイコロ" ] ]
            , li [] [ a [ href "src/timenow.html" ] [ Html.text "time今何時?" ] ]
            , li [] [ a [ href "src/maybetemperature.html" ] [ Html.text "Maybe華氏何度?" ] ]
            , li [] [ a [ href "src/passwordmatch.html" ] [ Html.text "パスワードマッチ" ] ]
            , li [] [ a [ href "src/fieldtoreverse.html" ] [ Html.text "テキストフィールドのサンプル" ] ]
            , li [] [ a [ href "src/httpgetrepository.html" ] [ Html.text "Httpのサンプル" ] ]
            , li [] [ a [ href "src/textformlist.html" ] [ Html.text "Formテキスト入力" ] ]
            , li [] [ a [ href "src/counter.html" ] [ Html.text "Counter.html" ] ]
            ]
        ]
